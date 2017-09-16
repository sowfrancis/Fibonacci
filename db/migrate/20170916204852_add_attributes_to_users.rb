class AddAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :number, :string
    add_column :users, :street, :string
    add_column :users, :zip, :string
    add_column :users, :city, :string
  end
end
