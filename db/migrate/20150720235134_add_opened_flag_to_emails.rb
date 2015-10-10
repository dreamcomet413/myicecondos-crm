class AddOpenedFlagToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :opened, :boolean, default: false
  end
end
