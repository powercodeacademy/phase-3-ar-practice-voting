class Voter < ActiveRecord::Base
  has_many :ballots
  has_many :candidates, through: :ballots

  # `Voter#vote(candidate, year)`
  # - takes a `candidate` (an instance of the `Candidate`
  #   class) and a `year` (integer) as arguments, and creates
  #   a new `ballot` in the database associated with the
  #   candidate and the voter

  # `Voter.voted_for(candidate)`
  # - takes a candidate (instance of a Candidate) argument,
  #   and returns all voters who have cast a ballot for that candidate
end