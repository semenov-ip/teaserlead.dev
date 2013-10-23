class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :password_digest
      t.string :roles, null: false, default: [:user]

      t.timestamp :last_sign_in_at, null: false, default: configus.date_0
      t.timestamps
    end
  end
end
