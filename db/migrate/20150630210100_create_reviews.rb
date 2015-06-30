class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :rating
      t.string :comment

      t.timestamps null: false
    end
  end
end
