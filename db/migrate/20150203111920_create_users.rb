class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :limit => 50
      t.string :uid, :limit => 50
      t.string :email
      t.string :access_token
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
