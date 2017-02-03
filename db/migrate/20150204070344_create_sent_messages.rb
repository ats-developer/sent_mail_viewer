class CreateSentMessages < ActiveRecord::Migration
  def change
    create_table :sent_messages do |t|
      t.integer :user_id
      t.integer :message_id
      t.string :to_name
      t.string :to_email
      t.string :subject
      t.datetime :sent_date

      t.timestamps null: false
    end
  end
end
