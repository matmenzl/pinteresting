class AddStatusToPins < ActiveRecord::Migration
  def change
    add_column :pins, :status, :string, default: "available"
  end
end
