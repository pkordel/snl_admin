class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.string  :title
      t.text    :description
      t.integer :position, default: 0
      t.string  :ancestry

      t.timestamps
    end
  end
end
