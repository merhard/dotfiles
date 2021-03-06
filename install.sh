#!/usr/bin/env ruby

require 'fileutils'

excludes = %w[install.sh README.md]

dotfiles = Dir[File.join(__dir__, '*')].map { |f| File.basename(f) } - excludes

totals = { symlinked: 0, skipped: 0 }

puts "Symlinking dotfiles to: #{Dir.home}"

dotfiles.each do |dotfile|
  source      = File.join(__dir__, dotfile)
  destination = File.join(Dir.home, ".#{dotfile}")

  if File.exist?(destination)
    puts "Skipping (already exists): #{destination}"
    totals[:skipped] += 1
  else
    FileUtils.symlink(source, destination)
    totals[:symlinked] += 1
  end
end

puts
puts "Symlinked: #{totals[:symlinked]}; Skipped: #{totals[:skipped]}"
