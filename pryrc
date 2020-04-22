if (history_file = ENV["IRB_HISTFILE"])
  Pry.config.history.file = history_file
end
