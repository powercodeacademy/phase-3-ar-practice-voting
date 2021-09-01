require_relative "spec_helper"

describe Voter do
  describe "attributes" do
    it "has data attributes given to it from a migration file" do
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")

      expect(gillian).to have_attributes(
        name: "Gillian Wenhold",
        party: "Democrat",
        age: 25
      )
    end
  end

  describe "associations" do
    it "has many ballots" do
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      tami = Candidate.create(name: "Tami Sawyer", party: "Democrat", seat: "Mayor")
      sue_ballot = Ballot.create(year: 2016, voter: gillian, candidate: sue)
      tami_ballot = Ballot.create(year: 2018, voter: gillian, candidate: tami)

      expect(gillian.ballots).to eq([sue_ballot, tami_ballot])
    end

    it "has many candidates through ballots" do
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      tami = Candidate.create(name: "Tami Sawyer", party: "Democrat", seat: "Mayor")
      sue_ballot = Ballot.create(year: 2016, voter: gillian, candidate: sue)
      tami_ballot = Ballot.create(year: 2018, voter: gillian, candidate: tami)

      expect(gillian.candidates).to eq([sue, tami])
    end
  end

  describe "other methods" do
  end
end