class CreateBallots < ActiveRecord::Migration[6.1]
  def change
    create_table :ballots do |t|
      t.integer :voter_id
      t.integer :candidate_id
      t.integer :year
    end
  end
end
