# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.destroy_all
Category.destroy_all
User.destroy_all
Review.destroy_all
QueueItem.destroy_all

Category.create([{id: 1, name: "TV Commedies"}, {id: 2, name: "TV Dramas"}, {id: 3, name: "Reality TV"}])

fut1 = Video.create(title: "monk", description: "Space Travel!", cover_image_url: "/tmp/monk.jpg", category_id: 1)
back1 = Video.create(title: "family guy", description: 'Time Travel!', cover_image_url: "/tmp/family_guy.jpg", category_id: 2)
south1 = Video.create(title: "South Park", description: 'South Park', cover_image_url: "/tmp/south_park.jpg", category_id: 3)

fut2 = Video.create(title: "monk2", description: "Space Travel!", cover_image_url: "/tmp/monk.jpg", category_id: 1)
back2 = Video.create(title: "family guy2", description: 'Time Travel!', cover_image_url: "/tmp/family_guy.jpg", category_id: 2)
south2 = Video.create(title: "South Park2", description: 'South Park', cover_image_url: "/tmp/south_park.jpg", category_id: 3)

fut = Video.create(title: "monk3", description: "Space Travel!", cover_image_url: "/tmp/monk.jpg", category_id: 1)
back = Video.create(title: "family guy3", description: 'Time Travel!', cover_image_url: "/tmp/family_guy.jpg", category_id: 2)
south = Video.create(title: "South Park3", description: 'South Park', cover_image_url: "/tmp/south_park.jpg", category_id: 3)

fut = Video.create(title: "monk4", description: "Space Travel!", cover_image_url: "/tmp/monk.jpg", category_id: 1)
back = Video.create(title: "family guy4", description: 'Time Travel!', cover_image_url: "/tmp/family_guy.jpg", category_id: 2)
south = Video.create(title: "South Park4", description: 'South Park', cover_image_url: "/tmp/south_park.jpg", category_id: 3)

fut = Video.create(title: "monk5", description: "Space Travel!", cover_image_url: "/tmp/monk.jpg", category_id: 1)
back = Video.create(title: "family guy5", description: 'Time Travel!', cover_image_url: "/tmp/family_guy.jpg", category_id: 2)
south = Video.create(title: "South Park5", description: 'South Park', cover_image_url: "/tmp/south_park.jpg", category_id: 3)

fut6 = Video.create(title: "monk6", description: "Space Travel!", cover_image_url: "/tmp/monk.jpg", category_id: 1)
back6 = Video.create(title: "family guy6", description: 'Time Travel!', cover_image_url: "/tmp/family_guy.jpg", category_id: 2)
south6 = Video.create(title: "South Park6", description: 'South Park', cover_image_url: "/tmp/south_park.jpg", category_id: 3)

fut7 = Video.create(title: "monk7", description: "Space Travel!", cover_image_url: "/tmp/monk.jpg", category_id: 1)
back7 = Video.create(title: "family guy7", description: 'Time Travel!', cover_image_url: "/tmp/family_guy.jpg", category_id: 2)
south7 = Video.create(title: "South Park7", description: 'South Park', cover_image_url: "/tmp/south_park.jpg", category_id: 3)

xiaocui = User.create(email: "barb@gmail.com", password: "12345", full_name: "Barbara")
cui = User.create(email: "ari@gmail.com", password: "12345", full_name: "Arita")
abc = User.create(email: "mario@gmail.com", password: "12345", full_name: "Mario")
ghi = User.create(email: "alan@gmail.com", password: "12345", full_name: "Alan")

Review.create(user: xiaocui, video: south7, content: "this is really nice movie!", rating: 5)
Review.create(user: cui, video: south7, content: "this is really nice movie!", rating: 5)
Review.create(user: xiaocui, video: fut7, content: "this is horrible movie!", rating: 3)
Review.create(user: cui, video: fut7, content: "this is horrible movie!", rating: 3)

Review.create(user: abc, video: south6, content: "this is really nice movie!", rating: 5)
Review.create(user: ghi, video: back6, content: "this is really nice movie!", rating: 5)
Review.create(user: abc, video: fut6, content: "this is horrible movie!", rating: 3)
Review.create(user: ghi, video: fut6, content: "this is horrible movie!", rating: 3)

QueueItem.create(user: abc, video: back, position: 2)
QueueItem.create(user: xiaocui, video: fut, position: 1)