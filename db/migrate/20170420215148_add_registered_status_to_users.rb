class AddRegisteredStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :registration_status, :integer, default: 0
  end
end
