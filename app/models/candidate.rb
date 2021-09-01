class Candidate < ActiveRecord::Base
  has_many :ballots
  has_many :voters, through: :ballots

  def count_votes(year)
    # takes a `year` (integer) as an argument,
    # and returns the amount of ballots cast for
    # the candidate that year
    ballots.where(year: year).count
  end

  def most_popular_year
    # returns the candidate's most successful election year
    # (the year where this candidate had the most ballots
    # cast for them)
    ballots_per_year = ballots.group(:year).count
    ballots_per_year.key(ballots_per_year.values.max) # https://stackoverflow.com/questions/6040494/how-to-find-the-key-of-the-largest-value-hash
    # OR USE THIS LINE INSTEAD OF LINE 17 ballots_per_year.max_by { |k, v| v }[0]
  end

  def voters_in_party_below_age(party, age)
    # takes a `party` (string) and `age` (integer) as arguments,
    # and returns all voters who have voted for this candidate
    # who belong to the given political party, and are YOUNGER
    # than the given age
    voters.where("party == ? AND age < ?", party, age)
    # OR USE THIS
    # voters.where(party: party)
    #       .where("age < ?", age)
  end
end