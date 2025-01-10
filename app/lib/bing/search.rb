module Bing
    class Search
        def self.web_results(query:, count:, mkt: nil)
            @apiKey ||= Rails.application.credentials.processor[:BingApiKey]
            if @apiKey.blank?
                raise "Bing API key is not set"
            end

            response = Faraday.get("https://api.bing.microsoft.com/v7.0/search") do |req|
                req.headers["Ocp-Apim-Subscription-Key"] = @apiKey
                req.params["q"] = query
                req.params["count"] = count
                req.params["mkt"] = mkt if mkt.present?
            end

            WebResults.new(query, count, JSON.parse(response.body))
        end

        class WebResults
            attr_reader :json, :query, :count

            def initialize(query, count, json)
                @query = query
                @count = count
                @json = json
            end

            # An example result in the json is:
            # {
            #  "name"=>"Safest New Cars of 2024, According to the IIHS",
            #  "url"=>"https://www.consumerreports.org/cars/car-safety/safest-new-cars-of-2024-according-to-iihs-a6646928467/",
            #  "thumbnailUrl"=>"https://www.bing.com/th?id=OIP.TbrENewT16zmJazopivsnwHaEK&w=80&h=80&c=1&pid=5.1",
            #  "datePublished"=>"2024-09-12T00:00:00.0000000",
            #  "datePublishedDisplayText"=>"12 de sept. de 2024",
            #  "isFamilyFriendly"=>true,
            #  "displayUrl"=>"https://www.consumerreports.org/cars/car-safety/safest-new-cars-of-2024-according-to...",
            #  "snippet"=>"Hyundai, Kia, and Genesis—which share corporate ownership—have the most awards overall. Toyota and Lexus come in second, and Mazda is third.",
            #  "dateLastCrawled"=>"2024-11-21T05:18:00.0000000Z",
            #  "primaryImageOfPage"=>{"thumbnailUrl"=>"https://www.bing.com/th?id=OIP.TbrENewT16zmJazopivsnwHaEK&w=80&h=80&c=1&pid=5.1", "width"=>80, "height"=>80, "sourceWidth"=>474, "sourceHeight"=>266, "imageId"=>"OIP.TbrENewT16zmJazopivsnwHaEK"},
            #  "cachedPageUrl"=>"http://cc.bingj.com/cache.aspx?q=safest+car+brands+for+women+over+45&d=4771545935406425&mkt=es-ES&setlang=es-ES&w=WAb3K-8mDKZ52XggkjfZy3ImIY2-sAUC",
            #  "language"=>"en",
            #  "isNavigational"=>false,
            #  "noCache"=>false,
            #  "siteName"=>"Consumer Reports",
            # }

            def list
                json.dig("webPages", "value").map do |result|
                    {
                        title: result.dig("name"),
                        url: result.dig("url"),
                        snippet: result.dig("snippet"),
                        cached_page_url: result.dig("cachedPageUrl")
                    }
                end
            end

            def matches_count
                json.dig("webPages", "totalEstimatedMatches")
            end

            def count
                json.dig("webPages", "value").count
            end

            def download
                json.dig("webPages", "value").map do |result|
                    html = download_page(result.dig("cachedPageUrl") || result.dig("url")) rescue nil
                    result.merge({ "html": html })
                end
            end

            private

            def download_page(url)
                begin
                    response = Faraday.get(url) do |req|
                        req.options.timeout = 5
                        req.options.open_timeout = 2
                    end
                rescue => e
                    Rails.logger.error("Error downloading page #{url}: #{e.message}")
                    return nil
                end

                if response&.status == 200
                    doc = Nokogiri::HTML(response.body)
                    doc.css("script, link, style").each { |node| node.remove }
                    doc.css("body").text.strip_heredoc
                else
                    nil
                end
            end
        end
    end
end
