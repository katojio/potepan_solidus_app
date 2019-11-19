require_relative 'config/application'

Rails.application.load_tasks

Rake::Task["assets:precompile"].enhance [:js_deps_install]
