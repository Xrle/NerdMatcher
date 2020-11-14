# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
Person.create(name: 'Bob TheBuilder', dob: '17/02/1990', bio: 'I love to fix things!', gender: 'Male')
Person.create(name: 'Postman Pat', dob: '04/12/1985', bio: 'If your post is late, i\'ll get irate!', gender: 'Male')
Person.create(name: 'Jerry Smith', dob: '25/05/2000', bio: 'My name is Jerry', gender: 'Male')
Person.create(name: 'Sarah Jane', dob: '11/09/1980', bio: 'Roses are red, violets are blue. I\'m running out of ideas, so let me put my Minecraft bed next to you ;)', gender: 'Female')