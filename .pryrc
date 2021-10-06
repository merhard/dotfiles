pry_version = Gem::Version.new(Pry::VERSION)

if (history_file = ENV["IRB_HISTFILE"])
  if pry_version < Gem::Version.new("0.13")
    Pry.config.history.file = history_file
  else
    Pry.config.history_file = history_file
  end
end
