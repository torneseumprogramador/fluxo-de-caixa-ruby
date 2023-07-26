class CreateCaixas < ActiveRecord::Migration[7.0]
  def change
    create_table :caixas do |t|
      t.string :tipo, limit: 200
      t.float :valor
      t.integer :status

      t.timestamps
    end
  end
end
