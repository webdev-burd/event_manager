require "csv"
require "sunlight/congress"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

puts "Event Manager".upcase

data = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

def clean_zipcode zipcode
  zipcode.to_s.rjust(5, "0")[0..4]
end

data.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

  puts "#{name} #{zipcode} #{legislators}"
end