class CreateEncyclopedia < ActiveRecord::Migration
  def change
    create_table :encyclopedia do |t|
      t.string :system_name

      t.timestamps
    end
  end
end
