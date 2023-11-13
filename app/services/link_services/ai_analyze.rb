module LinkServices
  class AiAnalyze
    def initialize(link: Link)
      @link = link
    end

    def run
      response = gpt_analyzer
      if response['tech'].to_f > 0.5
        @link.update(kind: Link.kinds.keys.include?(response['kind']) ? response['kind'] : 'other')
        response['tags'].each { |t| @link.tags << Tag.find_or_create_by(name: t) }
      else
        @link.need_review!
      end

      @link
    end

    private

    def gpt_analyzer
      object = { title: @link.title, description: @link.description, url: @link.link }
      client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key),
                                  organization_id: 'org-YeF1PAndkOGQdOpe38OlpQgo', request_timeout: 30)

      response = client.chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [
            { role: 'system',
              content: "Given a JSON-formatted object, identify the type of resource it represents from the following options:  #{Link.kinds.keys}. Generate up to five tags for the resource, ensuring relevance for developers or tech professionals. If possible, identify the resource's applicability to specific profiles such as backend, frontend, devops, ux/ui, marketing, software architect, data scientist, and more, and use a tag for each identified profile. Provide one downcased word if possible, and an acronym if the resource is a composed term. Additionally, include an indicator (a number from 0 to 1) to specify if the resource is related to technology or not. The response should be in JSON format and follow the structure: {\"kind\": 'identified kind', \"tags\": ['tag1', 'tag2', 'tag3', 'profile1', 'profile2', ...], \"tech\": 0.8}." },
            {
              role: 'user',
              content: "Analyze the object:  #{object.to_json}"
            }
          ],
          temperature: 0.5
        }
      )

      Rails.logger.debug("Full response: #{response}")

      JSON.parse(response.dig('choices', 0, 'message', 'content'))
    end
  end
end
