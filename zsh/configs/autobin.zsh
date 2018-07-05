function _rails_command () {
  if [ -e "bin/rails" ]; then
    bin/rails $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ] && grep '\srails\s' Gemfile.lock; then
    bundle exec rails $@
  else
    command rails $@
  fi
}
alias rails='_rails_command'

function _rake_command () {
  if [ -e "bin/rake" ]; then
    bin/rake $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ] && grep '\srake\s' Gemfile.lock; then
    bundle exec rake $@
  else
    command rake $@
  fi
}
alias rake='_rake_command'

function _rspec_command () {
  if [ -e "bin/rspec" ]; then
    bin/rspec $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ] && grep '\srspec-core\s' Gemfile.lock; then
    bundle exec rspec $@
  else
    command rspec $@
  fi
}
alias rspec='_rspec_command'
