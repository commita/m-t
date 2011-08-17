module MonospacedThoughts
  class HerokuCache
    # 1 year
    DEFAULT_AGE = 365 * 24 * 3600

    def initialize(app)
      @app = app
    end

    def call(*args)
      status, headers, body = @app.call(*args)
      headers['Cache-Control'] = "public, max-age=#{DEFAULT_AGE}"
      [status, headers, body]
    end
  end
end
