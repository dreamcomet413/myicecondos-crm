class AddSourceToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :source, :string
  end
end
