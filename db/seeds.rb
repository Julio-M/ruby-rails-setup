# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

d1 = Doctor.create(first_name:"Julius",last_name:"Hibbert")
d2 = Doctor.create(first_name:"Algemop",last_name:"Krieger")
d3 = Doctor.create(first_name:"Nick",last_name:"Riviera")

p1 = Patient.create(first_name:"Sterling",last_name:"Archer")
p2 = Patient.create(first_name:"Cyril",last_name:"Figis")
p3 = Patient.create(first_name:"Ray",last_name:"Gilette")
p4 = Patient.create(first_name:"Lana",last_name:"Kane")
