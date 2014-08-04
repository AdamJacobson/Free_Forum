echo "-- Reseting... --"
bundle exec rake db:reset
echo "-- Migrating... --"
bundle exec rake db:migrate
echo "-- Populating... --"
bundle exec rake db:populate
echo "-- Preparing... --"
bundle exec rake test:prepare
