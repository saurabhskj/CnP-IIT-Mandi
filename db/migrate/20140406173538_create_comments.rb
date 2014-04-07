class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.string :email

      t.references :forum
      t.timestamps
    end
    add_index :comments, :forum_id
  end
end
