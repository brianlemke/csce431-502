class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.string :file
      t.string :title
      t.boolean :verified

      t.timestamps
    end
  end
end
