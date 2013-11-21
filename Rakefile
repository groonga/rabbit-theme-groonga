# Copyright (C) 2013  Groonga Project
#
# License: CC BY 3.0

require "rabbit/task/theme"

spec = nil
Rabbit::Task::Theme.new do |task|
  spec = task.spec
end

desc "Tag the current version"
task :tag do
  sh("git", "tag", "-a", "-m", "#{spec.version} released!!!", spec.version.to_s)
  sh("git", "push", "--tags")
end
