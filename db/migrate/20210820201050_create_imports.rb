class CreateImports < ActiveRecord::Migration[6.0]
  def change
    create_table :imports do |t|
      t.string :title
      t.string :attachment
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :state, default: 0
      t.integer :invalid_customers, default: 0

      t.timestamps
    end
  end
end
