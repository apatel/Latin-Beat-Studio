# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "SEEDING DATABASE..."

users = User.create([
  {username: "admin", email: "admin@test.com", password: "123456", password_confirmation: "123456", admin: true},
  {username: "anita", email: "anita@test.com", password: "123456", password_confirmation: "123456"}
])

class_types = ClassType.create([
  { name: 'Zumba® Fitness', description: 'Let the joy of movement and rhythms from around the globe inspire you during our popular 60-minute Zumba® Fitness class! Great for all levels.', active: true },
  { name: 'Strong by Zumba®', description: 'Our STRONG by Zumba™ class combines high intensity interval training with the science of Synced Music Motivation. During this 60-minute class, let music push you past your perceived limits. Great for all levels.', active: true },
  { name: 'Tone and Sculpt', description: 'Tone up and slim down during our 60-minute Sculpt & Tone class. Combining muscle-toning exercises with cardio, you’ll blast your body into shape by focusing on core strength. Great for all levels.', active: true },
  { name: 'Yoga', description: 'Relax your mind and muscles during our 60-minute warming Yoga class. Enjoy the intimacy of a small class and the attention of a dedicated teacher. Great for all levels.', active: true },
  { name: 'Stretch and Recovery', description: 'Treat your mind and body to a break during our weekly Stretch & Recovery class. Our 60-minute  class is designed to slow down, restore your muscles and improve flexible. Great for all levels.', active: true },
  { name: 'Pilates Reformer', description: 'Our 60-minute pilates class combines resistance, lengthening and strength training You’ll be in a small group with everyone working on their own personal pilates machine.  Class size is limited to 4. Great for all levels.', active: true },
  { name: 'TRX', description: 'Increase your strength and learn to move the way your muscles are meant to in during our 60-minute TRX suspension class. This class will focus on different muscle group isolation, core strength and full body engagement. Class size is limited to 8.', active: true },
  { name: 'Bootcamp', description: "Our 60-minute circuit-style class combines muscle-toning techniques with explosive cardio to burn fat and get results. You'll also work one-on-one with Patricia to design a personalized nutrition plan to get you into the best shape of your life. All fitness levels are welcomed.", active: false }
])

passes = Pass.create([
  { name: 'Studio Beginner', description: '3 Zumba® Fitness classes plus one-on-one  30 minutes session prior to class.', price: 30.0, expiration_days: 30, quantity: 3, active: true },
  { name: 'Big Night Out', description: '1 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone  class per week', price: 35.0, expiration_days: 30, quantity: 4, active: true },
  { name: 'Double Down', description: '2 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes per week', price: 55.0, expiration_days: 30, quantity: 8, active: true },
  { name: 'Triple Threat', description: '3 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes per week', price: 72.0, expiration_days: 30, quantity: 12, active: true },
  { name: 'Zumba-licious', description: '1 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone class everyday', price: 80.0, expiration_days: 30, quantity: 30, active: true },
  { name: 'Studio Master', description: 'Unlimited Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes every day', price: 95.0, expiration_days: 30, quantity: 0, active: true },
  { name: 'Platinum', description: 'Unlimited Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes every day for 90 days', price: 250.0, expiration_days: 30, quantity: 0, active: true },

  { name: 'Pilates Reformer', description: '12 Pilates Reformer classes plus 12 complimentary Zumba® Fitness classes for 30 days (restrictions apply)', price: 300.0, expiration_days: 30, quantity: 12, active: true },
  { name: 'TRX®', description: '12 TRX®  Pilates Reformer classes plus 12 complimentary  Zumba® Fitness classes for 30 days (restrictions apply)', price: 300.0, expiration_days: 30, quantity: 12, active: true },
  { name: 'Bootcamp', description: '12 classes plus one-on-one nutritional coaching three times per week for four weeks', price: 300.0, expiration_days: 30, quantity: 12, active: true },
  { name: 'Stretch & Recovery', description: '4 Stretch & Recovery classes, once a week for four weeks', price: 30.0, expiration_days: 30, quantity: 4, active: true },

  { name: 'Single Class', description: 'Any Zumba® Fitness or Tone & Sculpt', price: 10.0, expiration_days: 7, quantity: 1, active: true },
  { name: 'STRONG by Zumba™', description: 'One STRONG by Zumba class™', price: 15.0, expiration_days: 7, quantity: 1, active: true },
  { name: 'New Member', description: 'First-time guests to the studio can enjoy any Zumba® Fitness, STRONG by Zumba™ or Tone & Sculpt for free', price: 0.0, expiration_days: 1, quantity: 1, active: true }
])

instructors = Instructor.create([
  { name: 'Nelson' },
  { name: 'Nicole' },
  { name: 'Patricia' },
  { name: 'Orisa' },
  { name: 'Marie' }
])

locations = Location.create([
  { name: 'Main Studio' },
  { name: 'Studio Two' },
  { name: 'External Location' }
])

studio_events = StudioEvent.create([
  { name: 'Master Class with Nelson', start_date: DateTime.new(2017,3,30,4,5,6), end_date: DateTime.new(2017,3,30,5,5,6), active: true },
  { name: 'Anniversary Party', start_date: DateTime.new(2017,6,14,4,5,6), end_date: DateTime.new(2017,6,14,7,5,6), active: true }
])

Pass.all.each do |pass|
  if pass.name == 'Studio Beginner'
    pass.class_types = [ClassType.find(1)]
  elsif pass.name == 'Big Night Out'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3), ClassType.find(4)]
  elsif pass.name == 'Double Down'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3), ClassType.find(4)]
  elsif pass.name == 'Triple Threat'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3), ClassType.find(4)]
  elsif pass.name == 'Zumba-licious'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3), ClassType.find(4)]
  elsif pass.name == 'Studio Master'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3), ClassType.find(4)]
  elsif pass.name == 'Platinum'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3), ClassType.find(4)]
  elsif pass.name == 'Pilates Reformer'
    pass.class_types = [ClassType.find(1), ClassType.find(6)]
  elsif pass.name == 'TRX®'
    pass.class_types = [ClassType.find(1), ClassType.find(7)]
  elsif pass.name == 'Bootcamp'
    pass.class_types = [ClassType.find(1), ClassType.find(8)]
  elsif pass.name == 'Stretch & Recovery'
    pass.class_types = [ClassType.find(5)]
  elsif pass.name == 'Single Class'
    pass.class_types = [ClassType.find(1), ClassType.find(3)]
  elsif pass.name == 'STRONG by Zumba™'
    pass.class_types = [ClassType.find(2)]
  elsif pass.name == 'New Member'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3)]
  end
end
puts "SEEDING COMPLETE!"
