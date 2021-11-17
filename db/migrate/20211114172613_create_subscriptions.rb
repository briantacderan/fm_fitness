class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :plan_id
      t.boolean :active, default: true
      t.string :interval, default: "monthly"
      t.datetime :current_period_ends_at
      t.string :stripe_id
      t.references :user
      t.timestamps
    end
  end
end
