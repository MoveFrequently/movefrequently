module Inference
    extend ActiveSupport::Concern

    def schema(&block)
        OpenAI::StructuredOutputs::Schema.new(&block)
    end

    def client
        OpenAI::StructuredOutputs::OpenAIClient.new
    end

    def chat(user_message, model: "gpt-4o-mini", temperature: 0, instructions: nil, schema: nil)
        messages = [ { role: :user, content: user_message } ]

        if instructions.present?
            messages.unshift({ role: :system, content: instructions })
        end

        parameters = {
            model: model,
            temperature: temperature,
            messages: messages
        }

        Rails.logger.debug("Sending message to #{model}: #{parameters.inspect}")
        result = if schema.present?
            parameters[:response_format] = schema
            client.parse(**parameters)
        else
            client.chat(parameters: parameters)
        end
        Rails.logger.debug("Received response from #{model}: #{result.inspect}")
        result
    end

    def assist(user_message, model: "gpt-4o-mini", temperature: 0, tools: [], instructions: nil, schema: nil)
        Rails.logger.debug("Creating assistant with model #{model}")

        llm = Langchain::LLM::OpenAI.new(
            api_key: Rails.application.credentials.processor[:OPENAI_API_KEY],
            default_options: {
                chat_model: model,
                temperature: temperature
            }
        )

        assistant = Langchain::Assistant.new(
            llm: llm,
            instructions: instructions,
            tools: tools,
        )

        if schema.present?
            parser = Langchain::OutputParsers::StructuredOutputParser.from_json_schema(schema.to_hash)
            prompt = Langchain::Prompt::PromptTemplate.new(template: "{format_instructions}\n{user_message}", input_variables: [ "user_message", "format_instructions" ])
            prompt_text = prompt.format(user_message: user_message, format_instructions: parser.get_format_instructions)
        else
            prompt_text = user_message
        end

        assistant.add_message(content: prompt_text)
        result = assistant.run(auto_tool_execution: true)

        if schema.present?
            begin
                parser.parse(result.last.content)
            rescue => e
                Rails.logger.error("Error parsing structured output: #{e.message}, returning raw version of the last response")
                result.last.content
            end
        else
            result.last.content
        end
    end
end
