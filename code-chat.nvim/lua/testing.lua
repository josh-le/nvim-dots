local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("cjson")

-- Function to make a request to an LLM API
function request_llm(api_url, prompt)
    -- Prepare request headers
    local headers = {
        ["Content-Type"] = "application/json",
    }

    -- Prepare request body
    local request_body = {
        model = model or "gpt-3.5-turbo", -- Default model if none provided
        messages = {
            {
                role = "user",
                content = prompt
            }
        },
        max_tokens = max_tokens or 150,  -- Default max_tokens if none provided
        temperature = 0.7
    }

    -- Convert request body to JSON
    local request_json = json.encode(request_body)

    -- Response table to collect the response
    local response_body = {}

    -- Make the HTTP request
    local res, code, response_headers = http.request {
        url = api_url,
        method = "POST",
        headers = headers,
        source = ltn12.source.string(request_json),
        sink = ltn12.sink.table(response_body)
    }

    -- Check for errors
    if code ~= 200 then
        print("Error: " .. code)
        if response_body[1] then
            print("Response: " .. table.concat(response_body))
        end
        return nil, code
    end

    -- Convert response to string and parse JSON
    local response_string = table.concat(response_body)
    local success, parsed_response = pcall(json.decode, response_string)

    if not success then
        print("Failed to parse JSON response")
        return nil, "JSON parse error"
    end

    return parsed_response, code
end

-- Function to extract the text from LLM response
function extract_llm_response(response)
    -- For OpenAI API
    if response.choices and response.choices[1] and response.choices[1].message then
        return response.choices[1].message.content
    -- For Anthropic Claude API
    elseif response.content and response.content[1] and response.content[1].text then
        return response.content[1].text
    -- For a generic response that might have direct completion
    elseif response.completion or response.text then
        return response.completion or response.text
    else
        print("Unknown response format")
        print("Full response: " .. json.encode(response))
        return nil, "Unknown response format"
    end
end

-- Example usage
local function main()
    local api_url = "https://api.openai.com/v1/chat/completions"  -- OpenAI example
    local api_key = "your_api_key_here"
    local prompt = "Explain the concept of recursion in programming."
    local model = "gpt-3.5-turbo"

    print("Sending request to LLM API...")
    local response, status_code = request_llm(api_url, api_key, prompt, model)

    if response then
        local llm_text, error = extract_llm_response(response)
        if llm_text then
            print("\nLLM Response:")
            print(llm_text)

            -- Further processing of the response
            print("\nToken usage:")
            if response.usage then
                print("Prompt tokens: " .. response.usage.prompt_tokens)
                print("Completion tokens: " .. response.usage.completion_tokens)
                print("Total tokens: " .. response.usage.total_tokens)
            end
        else
            print("Failed to extract response text: " .. (error or "unknown error"))
        end
    else
        print("Request failed with status code: " .. status_code)
    end
end

-- Run the example
main()
