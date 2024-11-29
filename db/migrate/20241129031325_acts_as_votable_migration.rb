class ActsAsVotableMigration < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, index: true
      t.references :voter, polymorphic: true, index: true

      t.boolean :vote_flag
      t.string :vote_scope
      t.integer :vote_weight

      t.timestamps
    end

    # เพิ่ม index
    add_index :votes, [:voter_id, :voter_type, :vote_scope]
    add_index :votes, [:votable_id, :votable_type, :vote_scope]
  end
end
