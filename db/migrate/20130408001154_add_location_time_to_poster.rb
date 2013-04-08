class AddLocationTimeToPoster < ActiveRecord::Migration
  def change
    add_column :posters, :location, :string
    add_column :posters, :event_start_date, :datetime
    add_column :posters, :event_end_date, :datetime
  end
end
