class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, index: true
      t.string :description
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
