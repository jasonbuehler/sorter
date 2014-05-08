class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.integer :number
      t.references :list, index: true

      t.timestamps
    end
  end
end
