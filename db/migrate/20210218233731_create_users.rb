class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password
      t.string :country
      t.integer :userType, default: 3

      t.timestamps
    end
  end
end
