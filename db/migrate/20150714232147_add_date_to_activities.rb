class AddDateToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :date, :date
    add_column :activities, :duration, :integer
    add_column :activities, :description, :text
  end
end
