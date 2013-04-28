class AddDescriptionToPoster < ActiveRecord::Migration
  def change
    add_column :posters, :description, :string
    add_column :posters, :tag, :string
    add_column :posters, :event_start_date, :datetime
    add_column :posters, :event_end_date, :datetime
  end
end
