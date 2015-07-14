class AddCompleteToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :complete, :boolean
  end
end
