require_relative "spec_helper"

describe Ballot do
  describe "attributes" do
    it "has data attributes given to it from a migration file" do
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      gillian_ballot = Ballot.create(year: 2016, voter: gillian, candidate: sue)

      expect(gillian_ballot).to have_attributes(
        year: 2016,
        voter_id: gillian.id,
        candidate_id: sue.id
      )
    end
  end

  describe "associations" do
    it "belongs to an Voter", :aggregate_failures do
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      gillian_ballot = Ballot.create(year: 2016, voter: gillian, candidate: sue)

      expect(gillian_ballot.voter).to be_an_instance_of(Voter)
      expect(gillian_ballot.voter).to eq gillian
    end

    it "belongs to a Candidate" do
      gillian = Voter.create(name: "Gillian Wenhold", age: 25, party: "Democrat")
      sue = Candidate.create(name: "Sue Minter", party: "Democrat", seat: "Governor")
      gillian_ballot = Ballot.create(year: 2016, voter: gillian, candidate: sue)

      expect(gillian_ballot.candidate).to be_an_instance_of(Candidate)
      expect(gillian_ballot.candidate).to eq sue
    end
  end

  describe "other methods" do
  end
end