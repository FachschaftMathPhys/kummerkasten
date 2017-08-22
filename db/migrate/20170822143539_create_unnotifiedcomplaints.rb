class CreateUnnotifiedcomplaints < ActiveRecord::Migration[5.1]
  def change
    create_table :unnotifiedcomplaints do |t|
      t.references :lecturer, foreign_key: true
      t.references :complaint, foreign_key: true

      t.timestamps
    end
  end
end
