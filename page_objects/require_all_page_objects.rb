# Require all models
Dir[File.expand_path(File.dirname(__FILE__)) + '/**/*.rb'].each {|f|
  require_relative(f)
}