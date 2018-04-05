class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
      create_table :users do |t|
          t.string :user_name
          t.string :password
          t.string :first_name
          t.string :last_name
          t.string :email
          t.string :nickname
          t.string :hobbies
          t.string :font_color
          t.string :bg_color
      end
  end
end
