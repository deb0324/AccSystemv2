# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(code: "A01", name: "A01_name", password: "12345")
user2 = User.create(code: "A02", name: "A02_name", password: "12345")
user3 = User.create(code: "A03", name: "A03_name", password: "12345")
user4 = User.create(code: "A04", name: "A04_name", password: "12345")
user5 = User.create(code: "A05", name: "A05_name", password: "12345")
user6 = User.create(code: "A06", name: "A06_name", password: "12345")
user7 = User.create(code: "A07", name: "A07_name", password: "12345")

user8 = User.create(code: "Y01", name: "admin1", password: "54321")
user9 = User.create(code: "Y02", name: "admin2", password: "54321")

user10 = User.create(code: "Z01", name: "closed", password: "54321")
user11 = User.create(code: "Z99", name: "moved", password: "54321")