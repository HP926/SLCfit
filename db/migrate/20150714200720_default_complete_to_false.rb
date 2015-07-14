class DefaultCompleteToFalse < ActiveRecord::Migration
  def change
    change_column :activities, :complete, :boolean, :default => false
  end
end
