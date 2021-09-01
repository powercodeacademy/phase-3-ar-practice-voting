class Voter < ActiveRecord::Base
  has_many :ballots
  has_many :candidates, through: :ballots

end