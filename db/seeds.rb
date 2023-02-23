# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'
require 'json'

puts "destroying movies"
Movie.destroy_all

puts "creating movies"

API_KEY = "439baa475bab7ee26968174cbfe4007a"

url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{API_KEY}&language=en-US&page=1"
response_serialized = URI.open(url).read
response = JSON.parse(response_serialized)

results = response["results"]
results.map do |result|
  movie = Movie.new(
    title: result["original_title"],
    overview: result["overview"],
    poster_url: result["poster_path"]
  )
  movie.save!
  puts movie.title
end
