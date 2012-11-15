class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :subject_id
      t.string :subject_type

      t.timestamps
    end
  end
end
