# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
role_types = Role.create([{ name: 'registered' }, { name: 'manager' }, { name: 'admin' }])
puts 'CREATED ROLE TYPES: ' << role_types.to_s
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
