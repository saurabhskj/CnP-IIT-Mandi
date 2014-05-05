class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :dob, :date
    add_column :users, :gender, :string
    add_column :users, :hostel_name, :string
    add_column :users, :hostel_address, :text
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :perm_citz_of_india, :bool
  end
end
