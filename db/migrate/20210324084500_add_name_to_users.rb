class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :image_icon, :string
    add_column :users, :introduction, :text
  end
end
