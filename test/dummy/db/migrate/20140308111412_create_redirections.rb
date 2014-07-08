class CreateRedirections < ActiveRecord::Migration
  def change
    create_table :redirections do |t|
      t.integer :from_encyclopedia_id
      t.string :permalink
      t.integer :to_encyclopedia_id
      t.string :to_permalink

      t.timestamps
    end
  end
end
