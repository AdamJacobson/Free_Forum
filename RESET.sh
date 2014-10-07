echo "== Migrating... =="
bundle exec rake db:migrate

echo "== Reseting... =="
bundle exec rake db:reset

echo "== Populating... =="
bundle exec rake db:populate

echo "== Preparing... =="
bundle exec rake test:prepare

echo "=== Seeding Test DB... ==="
bundle exec rake db:seed RAILS_ENV=test