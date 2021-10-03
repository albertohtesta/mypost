web: bin/rails server -p ${PORT:-5000}
worker: sidekiq -q default -q mailers

#web bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
#worker: sidekiq -q default -q mailers
#release: rails db:migrate
