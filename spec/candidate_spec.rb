require_relative "spec_helper"

describe Candidate do
  describe "attributes" do
    it "has data attributes given to it from a migration file" do
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")

      expect(sue).to have_attributes(
        name: "Sue Minter",
        party: "Democrat",
        seat: "Governor"
      )
    end
  end

  describe "associations" do
    it "has many ballots" do
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      jeffrey = Voter.create(name: "Jeffrey Peterson", age: 22, party: "Democrat")
      gillian_ballot = Ballot.create(year: 2016, voter: gillian, candidate: sue)
      jeffrey_ballot = Ballot.create(year: 2016, voter: jeffrey, candidate: sue)

      expect(sue.ballots).to eq([gillian_ballot, jeffrey_ballot])
    end

    it "has many voters through ballots" do
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      jeffrey = Voter.create(name: "Jeffrey Peterson", age: 22, party: "Democrat")
      Ballot.create(year: 2016, voter: gillian, candidate: sue)
      Ballot.create(year: 2016, voter: jeffrey, candidate: sue)

      expect(sue.voters).to eq([gillian, jeffrey])
    end
  end

  describe "other methods" do
    it "Candidate#count_votes(year)` takes a `year` (integer) as an argument, and returns the amount of ballots cast for the candidate that year" do
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      phil = Candidate.create(name: "Phil Scott", party: "Republican", seat: "Governor")
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      jeffrey = Voter.create(name: "Jeffrey Peterson", age: 22, party: "Democrat")
      Ballot.create(year: 2016, voter: gillian, candidate: sue)
      Ballot.create(year: 2018, voter: gillian, candidate: sue)
      Ballot.create(year: 2018, voter: jeffrey, candidate: phil)

      expect(sue.count_votes(2018)).to eq(1)
    end

    it "Candidate#most_popular_year returns the candidate's most successful election year (the year where this candidate had the most ballots cast for them)" do
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      jeffrey = Voter.create(name: "Jeffrey Peterson", age: 22, party: "Democrat")
      Ballot.create(year: 2016, voter: gillian, candidate: sue)
      Ballot.create(year: 2018, voter: gillian, candidate: sue)
      Ballot.create(year: 2018, voter: jeffrey, candidate: sue)

      expect(sue.most_popular_year).to eq(2018)
    end

    it "Candidate#voters_in_party_below_age(party, age)` takes a `party` (string) and `age` (integer) as arguments, and returns all voters who have voted for this candidate who belong to the given political party, and are YOUNGER than the given age", :aggregate_failures do
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      jeffrey = Voter.create(name: "Jeffrey Peterson", age: 22, party: "Republican")
      phil = Voter.create(name: "Phil Scott", age: 52, party: "Democrat")
      Ballot.create(year: 2016, voter: gillian, candidate: sue)
      Ballot.create(year: 2018, voter: jeffrey, candidate: sue)
      Ballot.create(year: 2018, voter: phil, candidate: sue)

      expect(sue.voters_in_party_below_age("Democrat", 30)).to include gillian
      expect(sue.voters_in_party_below_age("Democrat", 30)).not_to include phil
      expect(sue.voters_in_party_below_age("Democrat", 30)).not_to include jeffrey
    end

    it "Candidate.seats_in_party(party)` takes a `party` (string) as an argument and returns an array of all seats that candidates belonging to that party are running for" do
      Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      Candidate.create(name: "Phil Scott", party: "Republican", seat: "Governor's Mansion")
      Candidate.create(name: "Tami Sawyer", party: "Democrat", seat: "Mayor")
      Candidate.create(name: "W. W. Herenton", party: "Democrat", seat: "Mayor")

      expect(Candidate.seats_in_party("Democrat")).to eq(["Governor", "Mayor"])
    end

    it "Candidate.most_popular_for(seat)` takes a `seat` (string) as an argument, and returns the Candidate with the most ballots cast who is running for the given seat" do
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      phil = Candidate.create(name: "Phil Scott", party: "Republican", seat: "Governor")
      voter = Voter.create(name: "VOOTERRR", party: "Democrat", age: 25)
      Ballot.create(year: 2020, candidate: sue, voter: voter)
      Ballot.create(year: 2020, candidate: sue, voter: voter)
      Ballot.create(year: 2020, candidate: phil, voter: voter)

      expect(Candidate.most_popular_for("Governor")).to eq(sue)
    end
  end
end