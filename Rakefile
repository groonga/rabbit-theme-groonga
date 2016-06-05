# Copyright (C) 2013-2016  Groonga Project
#
# License: CC BY 3.0

require "rabbit/task/theme"

spec = nil
Rabbit::Task::Theme.new do |task|
  task.required_rabbit_version = ">= 2.2.0"
  spec = task.spec
end

desc "Tag the current version"
task :tag do
  sh("git", "tag", "-a", "-m", "#{spec.version} released!!!", spec.version.to_s)
  sh("git", "push", "--tags")
end
