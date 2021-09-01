# This will delete any existing rows from the Movie and Actor tables
# so you can run the seed file multiple times without having duplicate entries in your database
puts "Deleting voter/candidate/ballot data..."
Ballot.destroy_all
Voter.destroy_all
Candidate.destroy_all

parties = ["Democrat", "Republican", "Independent"]
offices = ["House of Representatives", "Senate", "Governor"]

puts "Creating voters..."
20.times do
  Voter.create(name: Faker::Name.name, age: rand(18..70), party: parties[rand(0..2)])
end

puts "Creating candidates..."
10.times do
  Candidate.create(name: Faker::Name.name, party: parties[rand(0..2)], office: offices[rand(0..2)])
end

puts "Creating ballots..."
150.times do
  # Get a voter instance:
  voter_id = Voter.ids.sample
  # Get a candidate instance:
  candidate_id = Candidate.ids.sample
  # Get a random year between 2000 and 2020:
  year = rand(2000..2020)

  # TODO: create ballots! Remember, a ballot belongs to a voter
  # and a ballot belongs to a candidate.
end

puts "Seeding done!"