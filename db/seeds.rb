# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(
#   nickname: 'hoge',
#   email: 'admin@example.com',
#   password: 'password'
# )

require "csv"

CSV.foreach('db/category.csv') do |row|
  Category.create(:id => row[0], :category => row[1], :ancestry => row[2])
end
CSV.foreach('db/size.csv') do |row|
  Size.create(:id => row[0], :size => row[1], :ancestry => row[2])
end
CSV.foreach('db/category_size.csv') do |row|
  CategorySize.create(:id => row[0], :category_id => row[1], :size_id => row[2])
end