require 'bundler/gem_tasks'

task :console do
  require 'pry'
  require 'yuki'

  def reload!
    # Change 'gem_name' here too:
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/yuki-ruby\// }
    files.each { |file| load file }
  end

  ARGV.clear
  Pry.start
end
