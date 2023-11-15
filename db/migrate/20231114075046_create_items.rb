class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :tax_included_price, null: false
      t.boolean :is_saled, default: true, null: false

      t.timestamps
    end
  end
end
