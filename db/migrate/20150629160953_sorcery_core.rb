class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.string :time_zone

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end