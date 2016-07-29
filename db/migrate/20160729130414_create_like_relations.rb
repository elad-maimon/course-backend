class CreateLikeRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :like_relations do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end

    add_index :like_relations, :post_id
    add_index :like_relations, [:post_id, :user_id], unique: true
  end
end
