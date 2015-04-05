class AddZipToPins < ActiveRecord::Migration
  def change
    add_column :pins, :zip, :string
  end
end
