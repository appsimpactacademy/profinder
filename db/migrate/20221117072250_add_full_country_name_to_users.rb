class AddFullCountryNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_country_name, :string
  end
end
