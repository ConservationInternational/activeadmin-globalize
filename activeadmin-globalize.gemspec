$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'active_admin/globalize/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'activeadmin-globalize'
  s.version     = ActiveAdmin::Globalize::VERSION
  s.authors     = ['Stefano Verna', 'Fabio Napoleoni', 'Alex Zvoleff']
  s.email       = ['stefano.verna@gmail.com', 'f.napoleoni@gmail.com', 'azvoleff@conservation.org']
  s.homepage    = 'http://github.com/ConservationInternational/activeadmin-globalize'
  s.summary     = 'Handles globalize translations'
  s.description = 'Handles globalize translations in ActiveAdmin 1.0 and Rails 7.x with globalize 7.0+'

  s.files = Dir['{app,config,db,lib}/**/*'] + %w(MIT-LICENSE README.md)

  s.add_dependency 'activeadmin', '>= 3.1.0', '< 4.0'
  # Support Rails 7.0+ with globalize 7.0+
  s.add_dependency 'globalize', '>= 7.0.0'

  # development dependencies
  s.add_development_dependency 'bundler', '>= 1.6.1'
  s.add_development_dependency 'rake'
  # Other development dependencies moved into Gemfile

end
