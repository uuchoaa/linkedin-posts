# frozen_string_literal: true

require "net/http"

class PostBodyGenerator
  def initialize(post)
    @post = post
  end

  def call
    uri = URI("#{ollama_url}/api/generate")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request.body = {
      model: ollama_model,
      system: system_prompt,
      prompt: user_prompt,
      stream: false
    }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https", read_timeout: 120) do |http|
      http.request(request)
    end

    return nil unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    data["response"]&.strip
  rescue JSON::ParserError, Errno::ECONNREFUSED, SocketError
    nil
  end

  private

  def system_prompt
    "You are a LinkedIn content writer. Write engaging, professional LinkedIn posts. Use line breaks for readability. Keep it concise (150-300 words). Include the hashtags at the end."
  end

  def user_prompt
    parts = []
    parts << "Title: #{@post.title}" if @post.title.present?
    parts << "Hook: #{@post.hook}" if @post.hook.present?
    parts << "Content to cover: #{@post.content_summary}" if @post.content_summary.present?
    parts << "Key insight to include: #{@post.senior_insight}" if @post.senior_insight.present?
    parts << "CTA / question to end with: #{@post.cta}" if @post.cta.present?
    parts << "Hashtags to use: #{@post.hashtags.join(' ')}" if @post.hashtags.any?
    "Write a LinkedIn post based on this outline:\n\n#{parts.join("\n\n")}"
  end

  def ollama_url
    ENV.fetch("OLLAMA_URL", "http://localhost:11434")
  end

  def ollama_model
    ENV.fetch("OLLAMA_MODEL", "deepseek-coder")
  end
end
