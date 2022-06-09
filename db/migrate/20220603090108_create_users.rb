class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string 'email', index: { unique: true }
      t.string 'first_name'
      t.string 'last_name'
      t.string 'password_digest'
      t.datetime 'dob'
      t.timestamps
    end
  end
end
