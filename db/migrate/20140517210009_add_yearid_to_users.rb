class AddYearidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :year_of_graduation_id, :integer
  end
end
