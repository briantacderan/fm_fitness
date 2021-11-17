class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :description
      t.string :currency
      t.string :amount
      t.references :program
      t.timestamps
    end
  end
end
