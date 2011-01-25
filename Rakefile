require 'toto'
require 'yaml'

@config = Toto::Config::Defaults
@config.update(YAML.load_file('config.yml'))

task :default => :new

desc "Create a new article."
task :new do
  title = ENV['TITLE'] || ask('Title: ')
  slug = title.empty?? nil : title.strip.slugize

  now = Time.now
  article = {'title' => title, 'date' => now.strftime("%d/%m/%Y"), 'author' => @config[:author]}.to_yaml
  article << "\n"
  article << "Once upon a time...\n\n"

  path = "#{Toto::Paths[:articles]}/#{now.strftime("%Y-%m-%d")}#{'-' + slug if slug}.#{@config[:ext]}"

  unless File.exist? path
    File.open(path, "w") do |file|
      file.write article
    end
    toto "an article was created for you at #{path}"
  else
    toto "I can't create the article, #{path} already exists."
  end
end

desc "Publish my blog."
task :publish do
  toto "publishing your article(s)..."
  `git push heroku master`
end

def toto msg
  puts "\n  toto ~ #{msg}\n\n"
end

def ask message
  print message
  STDIN.gets.chomp
end

