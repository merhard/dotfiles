function killport() {
  kill `sudo lsof -t -i:$1`
}
