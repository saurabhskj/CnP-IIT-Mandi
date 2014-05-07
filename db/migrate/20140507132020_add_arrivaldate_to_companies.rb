class AddArrivaldateToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :arrival_date, :date
  end
end
