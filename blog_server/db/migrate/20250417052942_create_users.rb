class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :email
      t.string :phone_number
      t.string :password
      t.date :dob
      t.boolean :is_active
      t.string :role, default: "user"

      t.timestamps
    end
  end
end
