class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :venue
      t.datetime :time_start
      t.datetime :time_end
      t.references :host, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :events, :created_at
  end
end
