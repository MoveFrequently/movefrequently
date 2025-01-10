require "httpx/adapters/faraday"

Faraday.default_connection = Faraday.new do |conn|
  if Rails.env.test?
    conn.use VCR::Middleware::Faraday
  end

  conn.use Faraday::FollowRedirects::Middleware
  # conn.headers = { "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" }
  conn.adapter :httpx
end
