class AddCustomAliasAndExpiryDateToUrls < ActiveRecord::Migration[7.1]
  def change
    add_column :urls, :custom_alias, :string
    add_column :urls, :expiry_date, :datetime
  end
end
