# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

demo_user = User.new({full_name: "demo", email: "demo@textcaptcha.ir", api_key: "demo"},
  without_protection: true)
demo_user.skip_textcaptcha = true
demo_user.save!
