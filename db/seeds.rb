# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "SEEDING DATABASE..."


users = User.create([
  {username: "admin", email: "admin@test.com", password: "123456", password_confirmation: "123456", admin: true, waiver: true},
  {username: "anita", email: "anita@test.com", password: "123456", password_confirmation: "123456", waiver: true}
])

class_types = ClassType.create([
  { name: 'Zumba® Fitness', description: 'Let the joy of movement and rhythms from around the globe inspire you during our popular 60-minute Zumba® Fitness class! Great for all levels.', active: true, color: "3C991E" },
  { name: 'Strong by Zumba®', description: 'Our STRONG by Zumba™ class combines high intensity interval training with the science of Synced Music Motivation. During this 60-minute class, let music push you past your perceived limits. Great for all levels.', active: true, color: "CC0000" },
  { name: 'Latin Beat Workout: Ultimate Tone & Sculpt', description: 'Tone up and slim down during our 60-minute Sculpt & Tone class. Combining muscle-toning exercises with cardio, you’ll blast your body into shape by focusing on core strength. Great for all levels.', active: true },
  { name: 'Yoga', description: 'Relax your mind and muscles during our 60-minute warming Yoga class. Enjoy the intimacy of a small class and the attention of a dedicated teacher. Great for all levels.', active: true },
  { name: 'Stretch and Recovery', description: 'Treat your mind and body to a break during our weekly Stretch & Recovery class. Our 60-minute  class is designed to slow down, restore your muscles and improve flexible. Great for all levels.', active: true },
  { name: 'Pilates Reformer', description: 'Our 60-minute pilates class combines resistance, lengthening and strength training You’ll be in a small group with everyone working on their own personal pilates machine.  Class size is limited to 4. Great for all levels.', active: true },
  { name: 'TRX', description: 'Increase your strength and learn to move the way your muscles are meant to in during our 60-minute TRX suspension class. This class will focus on different muscle group isolation, core strength and full body engagement. Class size is limited to 8.', active: true },
  { name: 'Bootcamp', description: "Our 60-minute circuit-style class combines muscle-toning techniques with explosive cardio to burn fat and get results. You'll also work one-on-one with Patricia to design a personalized nutrition plan to get you into the best shape of your life. All fitness levels are welcomed.", active: false },
  { name: 'Special', description: "Special events.", active: true }
])

passes = Pass.create([
  { name: 'Latin Beat Sampler', description: '3 classes total of Zumba, Strong by Zumba, Ultimate Tone & Sculpt and Yoga classes of your choice', price: 30.0, expiration_days: 30, quantity: 3, active: true, embed_code: 'https://squareup.com/market/latinbeat/beginners-package', category: 'Class Packages', view_order: 1 },
  { name: 'Big Night Out', description: '1 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone  class per week', price: 35.0, expiration_days: 30, quantity: 4, active: true, embed_code: 'https://squareup.com/market/latinbeat/item/big-night-out-package', category: 'Class Packages', view_order: 2 },
  { name: 'Double Down', description: '2 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes per week', price: 55.0, expiration_days: 30, quantity: 8, active: true, embed_code: 'https://squareup.com/market/latinbeat/item/double-down-package', category: 'Class Packages', view_order: 3 },
  { name: 'Triple Threat', description: '3 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes per week', price: 72.0, expiration_days: 30, quantity: 12, active: true, embed_code: 'https://squareup.com/market/latinbeat/item/triple-threat-package', category: 'Class Packages', view_order: 4 },
  { name: 'Zumba-licious', description: '1 Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone class everyday', price: 80.0, expiration_days: 30, quantity: 30, active: true, embed_code: 'https://squareup.com/market/latinbeat/item/zumba-licious-package', category: 'Class Packages', view_order: 5 },
  { name: 'Studio Masters', description: 'Unlimited Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes every day', price: 95.0, expiration_days: 30, quantity: 500, active: true, embed_code: 'https://squareup.com/market/latinbeat/item/master-package', category: 'Class Packages', view_order: 7 },
  { name: 'Platinum', description: 'Unlimited Zumba® Fitness, STRONG by Zumba™, Yoga or Sculpt & Tone classes every day for 90 days', price: 250.0, expiration_days: 90, quantity: 500, active: true, embed_code: 'https://squareup.com/market/latinbeat/item/platinum-package', category: 'Class Packages', view_order: 6 },

  { name: 'Pilates Reformer', description: '12 Pilates Reformer classes plus 12 complimentary Zumba® Fitness classes for 30 days (restrictions apply)', price: 300.0, expiration_days: 30, quantity: 12, active: true, category: 'Fitness Packages', view_order: 4 },
  { name: 'TRX®', description: '12 TRX®  Pilates Reformer classes plus 12 complimentary  Zumba® Fitness classes for 30 days (restrictions apply)', price: 300.0, expiration_days: 30, quantity: 12, active: true, category: 'Fitness Packages', view_order: 3 },
  { name: 'Bootcamp', description: '12 classes plus one-on-one nutritional coaching three times per week for four weeks', price: 300.0, expiration_days: 30, quantity: 12, active: true, category: 'Fitness Packages', view_order: 2 },
  { name: 'Stretch & Recovery', description: '4 Stretch & Recovery classes, once a week for four weeks', price: 30.0, expiration_days: 30, quantity: 4, active: true, category: 'Fitness Packages', view_order: 1 },

  { name: 'LBW: Ultimate Tone & Sculpt', description: '1 LBW class.', price: 15.0, expiration_days: 7, quantity: 1, active: true, category: 'A La Carte', view_order: 4 },
  { name: 'Yoga', description: '1 Yoga class.', price: 12.0, expiration_days: 7, quantity: 1, active: true, category: 'A La Carte', view_order: 3 },
  { name: 'STRONG by Zumba™', description: 'One STRONG by Zumba class™', price: 15.0, expiration_days: 7, quantity: 1, active: true, category: 'A La Carte', view_order: 2 },
  { name: 'New Member', description: 'First-time guests to the studio can enjoy any Zumba® Fitness, STRONG by Zumba™ or Tone & Sculpt for free', price: 0.0, expiration_days: 1, quantity: 1, active: true, category: 'A La Carte', view_order: 1 }
])

instructors = Instructor.create([
  { name: 'Patricia', title: 'Founder & Instructor' },
  { name: 'Nelson', title: 'Founder & Instructor' },
  { name: 'Nicole', title: 'Founder & Instructor' },
  { name: 'Orisa', title: 'Zumba® Instructor' },
  { name: 'Marie', title: 'Zumba® Instructor' },
  { name: 'Suzette', title: 'Zumba® Instructor' }
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

contents = Content.create([
  { title: 'Image', body: 'https://static1.squarespace.com/static/58a45494579fb36a5590ea7e/t/58a6f7bf6b8f5bf21d5375f7/1487337416181/family.png?format=750w', page: 'home', section: 'image' },
  { title: 'Exercise Your mind, body & soul.', body: 'Latin Beat Fitness Studio is dedicated to providing fun, safe and quality group fitness classes for all fitness levels. Whether you need to sweat, dance, sculpt or tone, we have something for you!', page: 'home', section: 'box' },
  { title: 'Image', body: 'https://static1.squarespace.com/static/58a45494579fb36a5590ea7e/t/58a6f7bf6b8f5bf21d5375f7/1487337416181/family.png?format=750w', page: 'studio', section: '1' }
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
    pass.class_types = [ClassType.find(8)]
  elsif pass.name == 'Stretch & Recovery'
    pass.class_types = [ClassType.find(5)]
  elsif pass.name == 'Single Class'
    pass.class_types = [ClassType.find(1), ClassType.find(3), ClassType.find(4)]
  elsif pass.name == 'LBW: Ultimate Tone & Sculpt'
    pass.class_types = [ClassType.find(3)]
  elsif pass.name == 'Yoga'
    pass.class_types = [ClassType.find(4)]
  elsif pass.name == 'STRONG by Zumba™'
    pass.class_types = [ClassType.find(2)]
  elsif pass.name == 'New Member'
    pass.class_types = [ClassType.find(1), ClassType.find(2), ClassType.find(3)]
  end
end
puts "SEEDING COMPLETE!"
