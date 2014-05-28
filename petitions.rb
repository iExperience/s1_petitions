require 'rest-client'
require 'json'

puts "Hello! Welcome to Petitions!"
puts "Search for petitions:"

search = gets.strip
offset = 0

while true

	puts "Loading results..."

	puts

	response = RestClient.get("https://api.whitehouse.gov/v1/petitions.json" + 
		"?limit=5&offset=#{offset}&title=#{search}")

	parsed_response = JSON.parse(response)

	petitions = parsed_response["results"]

	petitions.each_with_index do |petition, index|
		puts "#{offset+index+1}. #{petition["title"]}\n(SIGN HERE: #{petition["url"]})"
		puts
	end

	offset += petitions.size

	puts "Would you like to see more? (y or n)"

	input = gets.strip.downcase

	break if (input == "n" || input == "no")
end
