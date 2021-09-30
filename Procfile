web bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
worker: sidekiq -C config/sidekiq.yml
release: bin/rails db:migrate # esto para q despues del deploy corra las migraciones
