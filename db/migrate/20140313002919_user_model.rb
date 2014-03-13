class UserModel < ActiveRecord::Migration
  def change
  	#drop_table :users
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end
