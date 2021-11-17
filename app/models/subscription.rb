class Subscription < ApplicationRecord
    
  belongs_to :user
    
  def interrupt
    Stripe::Subscription.delete(stripe_id)
    self.active = false
    save
  end
    
end
