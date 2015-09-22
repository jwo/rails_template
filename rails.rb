gem "simple_form"
gem "normalize-rails"
gem "minitest-rails"

gem_group :test do
  gem "minitest-rails-capybara"
  gem "launchy"
end

gem_group :development do
  gem "travis"
end

gem_group :production do
  gem "rails_12factor"
end

file '.travis.yml', <<-CODE
language: ruby
rvm:
  - 2.2.2
addons:
  postgresql: "9.4"
before_script:
  - psql -c 'create database travis_ci_test;' -U postgres
  - cp config/database.yml.travis config/database.yml
CODE

file '.travis.yml', <<-CODE
test:
  adapter: postgresql
  database: travis_ci_test
  username: postgres
CODE

after_bundle do
  rake "db:create db:migrate"
  generate "simple_form:install"
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
  # run "hub create"
  # run "git push origin master"
  # run "travis init"
  # run "heroku create"
  # run "travis setup heroku"
  # git add: '.'
  # git commit: "-a -m 'Possibly ready for travisci'"
  # run "git push origin master"
end
