class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :api_key

      t.timestamps
    end

    add_index :users, :api_key
  end
end
