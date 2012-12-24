class AddApiKeySentAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_key_sent_at, :datetime
  end
end
