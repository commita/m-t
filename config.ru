# encoding: utf-8

$:.unshift File.expand_path("../lib", __FILE__)

require 'toto'
require 'yaml'
require 'mt'

use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger
use MonospacedThoughts::HerokuCache

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

config = YAML.load_file 'config.yml'

toto = Toto::Server.new do
  config.each do |key, value|
    set key, value
  end

  set :root, "index"
  set :markdown, :smart
  set :summary, :max => 5000, :delim => /~\n/
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }

  set :disqus_id, lambda {|article| "#{article[:date].strftime("%Y-%m-%d")} #{article.slug}" }
  set :disqus_url, lambda {|article| article.permalink }
end

run toto
