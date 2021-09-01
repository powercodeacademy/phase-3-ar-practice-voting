class Candidate < ActiveRecord::Base
  has_many :ballots
  has_many :voters, through: :ballots

end