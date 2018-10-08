class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.timestamp :date
      t.string :currency
      t.decimal :rate

      t.timestamps
    end
  end
end
