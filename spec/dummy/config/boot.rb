# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

# Ruby 3.4 compatibility - require these before Rails loads
begin
  require 'logger'
  require 'bigdecimal'
  require 'mutex_m'
  require 'base64'
  require 'csv'
  require 'drb'
rescue LoadError
  # Gems might not be available in all environments
end

$LOAD_PATH.unshift File.expand_path('../../../../lib', __FILE__)