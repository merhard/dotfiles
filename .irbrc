require "irb/completion"

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000

if (history_file = ENV["IRB_HISTFILE"])
  IRB.conf[:HISTORY_FILE] = history_file
end
