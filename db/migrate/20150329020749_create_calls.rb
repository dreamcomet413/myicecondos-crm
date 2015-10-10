class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.integer :lead_id
      t.text :notes
      t.string :title

      t.timestamps
    end
  end
end
