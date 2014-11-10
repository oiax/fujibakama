class CreatePrefectures < ActiveRecord::Migration
  def change
    create_table :prefectures do |t|
      t.string :name, null: true

      t.timestamps
    end
  end
end
