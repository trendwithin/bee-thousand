class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.string :symbol, null: false
      t.string :entry, null: false
      t.string :stop
      t.string :target
      t.integer :shares
      t.text :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
