class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :body
      t.references :poster

      t.timestamps
    end
    add_index :comments, :poster_id
  end
end
