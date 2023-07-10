# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def title
  [
    Faker::Movie.title + " screening",
    Faker::Sport.sport + " live",
    Faker::Music.band + " concert",
    Faker::Game.title + " match"].sample
end

30.times do |n|
  User.create(name: Faker::Name.name, email: "user#{n + 1}@email.com", password: "password")
end

30.times do |n|
  u = User.find(n + 1)
  rand(1..3).times do
    start = rand(0..3).years.from_now + rand(0..11).months + rand(0..24).hours
    e = u.events_hosted.create(title: title,
                        description: Faker::Movie.quote,
                        venue: Faker::Address.street_address,
                        time_start: start,
                        time_end: start + rand(1..10).hours)
  end
end

@event_ids = Event.pluck(:id)

30.times do |n|
  event_ids = @event_ids.sample(5)
  event_ids.each do |id|
    User.find(n + 1).attendances.create(event_attended_id: id)
  end
end
