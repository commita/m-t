# encoding: utf-8

Dir[File.expand_path("../middleware/*.rb", __FILE__)].each do |rb|
  require rb
end
