class RemoveActivationFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :activation_digest, :string
    remove_column :users, :activated, :boolean, default: false
    remove_column :users, :activated_at, :datetime
  end
end
