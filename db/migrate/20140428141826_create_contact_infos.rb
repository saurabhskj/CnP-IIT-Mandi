class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.integer :user_id
      t.string :phone_number1
      t.string :phone_number2
      t.string :personal_email
      t.string :college_email

      t.timestamps
    end
  end
end
