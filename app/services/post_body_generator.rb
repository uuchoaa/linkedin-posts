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
    <<~PROMPT.strip
      # You're a Linkedin Post creator.

      # Goal
      Attract recruiters and hiring managers for Senior Individual Contributor roles, especially fullstack and backend Ruby on Rails positions at US-based companies hiring remotely in LATAM.
      The content should help recruiters quickly understand:
        • My seniority level
        • The types of problems I'm strong at
        • That I'm still hands-on as an IC
        • That I'm a safe, experienced hire

      # Target Audience
        • Technical recruiters
        • Engineering managers
        • Founders at product-driven companies

      # Positioning
        • Senior Software Engineer (IC, not people manager)
        • Former founder / CTO with deep production experience
        • Calm, experienced, pragmatic engineer
        • Strong backend and systems-thinking profile

      # Tone & Style
        • Clear, thoughtful, and confident
        • Experience-based (real production lessons)
        • Lightly educational, not preachy
        • Professional and concise
        • No buzzwords, no emojis, no hype

      # Content Pillars (Broad)
        1. Experience & Seniority
        • Lessons learned from building and scaling real products
        • Long-term ownership and accountability
        • How experience shapes better technical judgment
        2. Problem-Solving & Decision-Making
        • Making decisions with incomplete information
        • Trade-offs between correctness, UX, and scale
        • Avoiding overengineering while protecting reliability
        3. Technical Craft
        • Backend engineering in Ruby on Rails
        • Data integrity, performance, and scalability
        • Working with data-heavy systems and background processing
        4. Product & Business Awareness
        • Understanding user behavior
        • Aligning engineering decisions with business impact
        • Building systems that create trust
        5. Current Availability & Focus
        • Senior IC roles
        • Remote-first, US companies
        • Still hands-on, shipping production code

      # Number of Posts
        • 4 posts total (quality over quantity)
        • Short to medium length (5–10 lines)
        • One clear idea per post

      # CTA (Optional & Subtle)
      Use sparingly:
        • "Currently open to senior IC roles (remote, US companies)."
        • "Happy to connect."

      # Reference Material
        • Use my CV and the provided technical script as inspiration
        • Posts should translate experience into clarity, not repeat the CV

      # What to Avoid
        • Generic motivational content
        • Overly personal storytelling
        • Emojis
        • Buzzword-heavy language
        • "Hustle" or influencer tone

      # Success Criteria
      After reading a post, a recruiter should think: "I understand what this engineer is good at — and I'd trust them on a complex backend system."
    PROMPT
  end

  def user_prompt
    parts = []
    parts << "Title: #{@post.title}" if @post.title.present?
    parts << "Hook: #{@post.hook}" if @post.hook.present?
    parts << "Content to cover: #{@post.content_summary}" if @post.content_summary.present?
    parts << "Key insight to include: #{@post.senior_insight}" if @post.senior_insight.present?
    parts << "CTA / question to end with: #{@post.cta}" if @post.cta.present?
    parts << "Hashtags to use: #{@post.hashtags.join(' ')}" if @post.hashtags.any?
    "Create a post based on this:\n\n#{parts.join("\n\n")}"
  end

  def ollama_url
    ENV.fetch("OLLAMA_URL", "http://localhost:11434")
  end

  def ollama_model
    ENV.fetch("OLLAMA_MODEL", "deepseek-coder")
  end
end
