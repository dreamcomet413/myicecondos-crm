class CreateLeadAssignmentRules < ActiveRecord::Migration
  def change
    create_table :lead_assignment_rules do |t|
      t.string :title
      t.string :source
      t.text :information

      t.timestamps
    end
  end
end
