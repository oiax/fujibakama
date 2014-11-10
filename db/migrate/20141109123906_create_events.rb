class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :prefecture, null: false
      t.string :title, null: false
      t.string :venue, null: false

      t.timestamps
    end

    add_foreign_key :events, :prefectures
  end
end
