class CreateVoters < ActiveRecord::Migration[6.1]
  def change
    create_table :voters do |t|
      t.string :name
      t.integer :age
      t.string :party
    end
  end
end
