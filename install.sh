#!/usr/bin/env ruby

require 'fileutils'

excludes = %w[. .. .git install.sh README.md]

dotfiles = Dir.glob('*', File::FNM_DOTMATCH, base: __dir__) - excludes

totals = { symlinked: 0, skipped: 0 }

puts "Symlinking dotfiles to: #{Dir.home}"
puts

padding = dotfiles.map(&:length).max + 5

dotfiles.each do |dotfile|
  source      = File.join(__dir__, dotfile)
  destination = File.join(Dir.home, dotfile)

  print dotfile.ljust(padding)

  if File.exist?(destination)
    puts "SKIPPED (already exists): #{destination}"
    totals[:skipped] += 1
  else
    FileUtils.symlink(source, destination)
    puts "SUCCESS"
    totals[:symlinked] += 1
  end
end

puts
puts "Symlinked: #{totals[:symlinked]}; Skipped: #{totals[:skipped]}"
