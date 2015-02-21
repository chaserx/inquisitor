class AddSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :settings, :hstore, default: '', null: false
  end
end
