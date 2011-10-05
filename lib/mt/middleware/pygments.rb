# encoding: utf-8

require 'cgi'
require 'digest'

module MonospacedThoughts
  module Middleware
    class Pygments
      def initialize(app, options={})
        @app = app
        @url = options[:url] || "/pygmentize"
        selector(options) or selector(xpath: "//pre[./code[contains(text(), 'pygment:')]]")
      end

      def call(env)
        if (env['PATH_INFO'].start_with? @url) && (env['REQUEST_METHOD'] == 'POST')
          req = Rack::Request.new(env)
          content = req.params['code']
          lang = req.params['lang']
          body = pygmentize(content, lang)
          headers = {
            'Content-Type' => "text/html",
            'Content-Length' => Rack::Utils.bytesize(body).to_s,
            'Cache-Control' => "public, max-age=#{HerokuCache::DEFAULT_AGE}"
          }
          [200, headers, [body]]
        else
          status, headers, res = @app.call(env)
          body = res.body.join("\n")
          body = mixin_pygments(env, body)
          headers['Content-Length'] = Rack::Utils.bytesize(body).to_s
          [status, headers, [body]]
        end
      end

      private

      def mixin_pygments(env, body)
        doc = Nokogiri.HTML body
        doc.send(@selector[:method], @selector[:value]).each do |node|
          split = node.text.split("\n")
          next if not split.first.strip =~ /^pygment:(.*)$/
          lang = $1
          code = split[1..-1].join("\n")
          node.replace pygmentize(code, lang)
        end
        doc.serialize
      end

      def request_pygment(env, content, lang)
        digest = Digest::SHA1.new(content).hexdigest
        uri = URI.parse "#{env['rack.url_scheme']}://#{env['HTTP_HOST'] || env['SERVER_NAME']}"
        uri.query = nil
        uri.path = "#{@url}/#{digest}"
        Curl::Easy.http_post uri.to_s,
          Curl::PostField.content('code', content),
          Curl::PostField.content('lang', lang)
      end

      def pygmentize(content, lang)
        content.encode! 'utf-8'
        Pygmentize.process content, lang
      end

      def selector(opts={})
        @selector ||= begin
          if opts.include?(m = :xpath) || opts.include?(m = :css)
            { method: m, value: opts[m] }
          end
        end
      end

    end
  end
end
