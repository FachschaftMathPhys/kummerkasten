# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)
for i in 0..50
  a = Faker::Internet.email
  puts a
  l= Lecturer.create!(sign_in_count:0,salutation:'Dear '+Faker::Name.prefix+' '+Faker::Name.suffix,surname:Faker::Name.last_name,password:"123456",givenname:Faker::Name.first_name,email:a,wantsreview:true)
  p l
end

Coursetype.create!(name: 'Vorlesung')
Coursetype.create!(name: 'Praktikum')
Coursetype.create!(name: 'Seminar')
Faculty.create!(name: 'Mathe und Informatik')
Faculty.create!(name: 'Physik und Astro')
Semester.create!(name: 'SS17', year: Date.today)
Semester.create!(name: 'WS16/17', year: 190.days.ago)
Semester.create!(name: 'SS16', year: 365.days.ago)
for i in 0..50
  a=Course.create!(name: Faker::Company.catch_phrase, abbreviation: Faker::Address.state_abbr, semester: Semester.offset(rand(Semester.count)).first, coursetype: Coursetype.offset(rand(Coursetype.count)).first, faculty: Faculty.offset(rand(Faculty.count)).first)
  Lecture.create!(course: a, lecturer: Lecturer.offset(rand(Lecturer.count)).first)
end
for i in 0..30
  Lecture.create!(course: Course.offset(rand(Course.count)).first, lecturer: Lecturer.offset(rand(Lecturer.count)).first)
end
for i in 0..100
  Complaint.create!(message: Faker::Lorem.sentence, approved: false, course: Course.offset(rand(Course.count)).first)
end
for i in 0..30
  c = Complaint.offset(rand(Complaint.count)).first
  d=c.lecturers
  Hasread.create!(lecturer: d.sample, complaint: c)
end
