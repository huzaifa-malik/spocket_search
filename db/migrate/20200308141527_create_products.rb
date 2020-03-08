class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.text :tags
      t.decimal :price

      t.references :country

      t.timestamps
    end
  end
end
