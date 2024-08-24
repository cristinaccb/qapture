# app/services/ollama_api.rb
class OllamaApi
  include HTTParty
  base_uri ENV['OLLAMA_API_URL'] || 'http://localhost:11434'

  def self.generate_instagram_caption(image_description)
    prompt = "Generate a catchy and engaging Instagram caption for an image with the following description: #{image_description}. The caption should be short, witty, and include relevant hashtags."

    Rails.logger.info "Generating Instagram caption for: #{image_description}"

    response = post('/api/generate', body: {
      model: "llava",
      prompt: prompt,
      stream: false
    }.to_json, headers: { 'Content-Type' => 'application/json' })

    if response.success?
      caption = JSON.parse(response.body)['response'].strip
      Rails.logger.info "Generated Instagram caption: #{caption}"
      caption
    else
      Rails.logger.error "API request failed. Status: #{response.code}, Body: #{response.body}"
      fallback_caption(image_description)
    end
  rescue => e
    Rails.logger.error "Exception occurred: #{e.message}\n#{e.backtrace.join("\n")}"
    fallback_caption(image_description)
  end

  private

  def self.fallback_caption(image_description)
    "Check out this amazing image! 📸✨ #NoFilter #InstaVibes"
  end
end
