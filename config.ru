require 'toto'
require 'yaml'

use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

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
end

run toto
