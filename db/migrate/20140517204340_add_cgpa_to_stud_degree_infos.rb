class AddCgpaToStudDegreeInfos < ActiveRecord::Migration
  def change
    add_column :stud_degree_infos, :cgpa, :real
  end
end
