class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :subject
      t.text :body
      t.integer :created_by_id
      t.datetime :created_at
    end
  end
end
