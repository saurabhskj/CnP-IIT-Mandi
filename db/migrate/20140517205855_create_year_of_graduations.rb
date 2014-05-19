class CreateYearOfGraduations < ActiveRecord::Migration
  def change
    create_table :year_of_graduations do |t|
      t.integer :year

      t.timestamps
    end
  end
end
