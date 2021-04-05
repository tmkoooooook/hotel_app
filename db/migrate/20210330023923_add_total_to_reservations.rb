class AddTotalToReservations < ActiveRecord::Migration[6.1]
  def change
      add_column :reservations, :total, :integer
  end
end
