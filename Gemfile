source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

# Use postgresql as the database for Active Record
gem 'pg'

# Use unicorn as the app server
gem 'puma'

# support for tree-like structures in ActiveRecord
gem "acts_as_tree"

# limit http request rates
gem "rack-throttle"

# provide Redis cache client
gem "redis"
gem "redis-rails"

# parse XML documents
gem "nokogiri"

# provide good serialization
gem "active_model_serializers"

# build APIs with ease :)
gem "grape"

# integrate Grape with AMS
gem "grape-active_model_serializers"

group :development, :test do
  # test application using RSpec
  gem 'rspec', '~> 3.1'
  gem 'rspec-rails'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # use Guard to observe file changes and run tests accordingly
  gem 'guard'
  gem 'guard-rspec'
end
