class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :user_id
      t.string :description
      t.string :url
      t.string :site

      t.timestamps
    end
  end
end
