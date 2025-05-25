# frozen_string_literal: true

module SallaSerializers
  class EmailInterceptor
    def self.delivering_email(message)
      if message.html_part
        html = message.html_part.body.decoded
        sanitized_html = sanitize_links(html)

        message.html_part = Mail::Part.new do
          content_type 'text/html; charset=UTF-8'
          body sanitized_html
        end
      end

      if message.text_part
        text = message.text_part.body.decoded
        sanitized_text = sanitize_links(text)

        message.text_part = Mail::Part.new do
          content_type 'text/plain; charset=UTF-8'
          body sanitized_text
        end
      elsif message.body
        message.body = sanitize_links(message.body.decoded)
      end
    end

    def self.sanitize_links(content)
      return content unless content

      from_url = ENV["REWRITE_FROM_URL"]&.chomp("/")
      to_url = ENV["REWRITE_TO_URL"]&.chomp("/")

      if from_url.present? && to_url.present?
        content = content.gsub(%r{#{Regexp.escape(from_url)}/?}, "#{to_url}/")
      end
    end
  end
end
