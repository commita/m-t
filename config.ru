# encoding: utf-8

TOTO_ENV = ENV["TOTO_ENV"] ||= ENV["RACK_ENV"] ||= "development" unless defined?(TOTO_ENV)

require 'bundler'
Bundler.setup
Bundler.require :default, TOTO_ENV.to_sym

$:.unshift File.expand_path("../lib", __FILE__)

require 'yaml'
require 'mt'

use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico', '/robots.txt'], :root => 'public'
use Rack::CommonLogger
use MonospacedThoughts::Middleware::Pygments
use MonospacedThoughts::Middleware::HerokuCache

if TOTO_ENV == 'development'
  use Rack::ShowExceptions
end

config = YAML.load_file 'config.yml'

toto = Toto::Server.new do
  config.each do |key, value|
    set key, value
  end

  set :root, "index"
  set :markdown, true
  set :summary, :max => 5000, :delim => /~\n/
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }

  set :disqus_id, lambda {|article| "#{article[:date].strftime("%Y-%m-%d")} #{article.slug}" }
  set :disqus_url, lambda {|article| article.permalink }
end

run toto
