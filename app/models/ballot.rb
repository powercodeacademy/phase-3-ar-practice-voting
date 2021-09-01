class Ballot < ActiveRecord::Base
  belongs_to :voter
  belongs_to :candidate

  # `Ballot#print_details`
  # - `puts` a string to the terminal to display the details of the ballot
  # - the string should be formatted like this:
  #   `{voter name} voted for {candidate name} in ${ballot year}`
end