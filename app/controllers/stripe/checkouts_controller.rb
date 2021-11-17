class Stripe::CheckoutsController < ApplicationController
  before_action :get_cart_total
  before_action :authenticate_user!
  
  def new
    add_cookie_to_cart(params) if params
    flash[:success] = "Cart updated"
    redirect_to root_path
  end

  def show
  end

  def create
    if current_user.stripe_id?
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
    else
      customer = StripeTool.create_customer(
        email: current_user.email
      )
    end
    
    current_user.update!(stripe_id: customer.id)
    stripe_session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: session[:line_items],
      customer: customer.id,
      client_reference_id: current_user.id,
      mode: 'payment',
      success_url: "#{stripe_thanks_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: root_url
    })
      
    redirect_to stripe_session.url
  rescue Stripe::InvalidRequestError => e
    flash[:error] = 'You silly goose! Your cart is empty!'
    redirect_to stripe_cart_path
  end
 
  def thanks
    session.delete(:line_items)
    flash[:success] = "Purchase successful"
  end

  def destroy
    session.delete(:line_items)
    flash[:success] = "Cart deleted"
    redirect_to stripe_cart_path
  end

  def webhook
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    begin
      event = Stripe::Webhook.construct_event(request.body.read, sig_header, ENV['STRIPE_ENDPOINT_SECRET'])
    rescue JSON::ParserError
      return head :bad_request
    rescue Stripe::SignatureVerificationError
      return head :bad_request
    end

    webhook_checkout_session_completed(event) if event['type'] == 'checkout.session.completed'

    head :ok
  end

  def interrupt
    current_user.subscription.interrupt
  end
    
  
  private
    
  def add_cookie_to_cart(params)
    price = params[:item][:menu_id].to_i == 1 ? 150 : 200
    line_item = {
      price_data: {
        unit_amount: price,
        currency: 'usd',
        product_data: {
          name: params[:item][:name],
          images: [params[:item][:image]]
        },
      },
      quantity: params[:item][:quantity]
    }
    session[:line_items].push(line_item)
  end

  def get_cart_total
    @amount = 0
    if session[:line_items]
      session[:line_items].each do |i|
        quantity = i['quantity'].to_i
        price = i['price_data']['unit_amount'].to_i
        @amount += price * quantity
      end
    else
      session[:line_items] = Array.new
    end
  end

  def build_subscription(stripe_subscription)
    Subscription.new(plan_id: stripe_subscription.plan.id,
                     stripe_id: stripe_subscription.id,
                     current_period_ends_at: Time.zone.at(stripe_subscription.current_period_end))
  end

  def webhook_checkout_session_completed(event)
    object = event['data']['object']
    customer = Stripe::Customer.retrieve(object['customer'])
    #stripe_subscription = Stripe::Subscription.retrieve(object['subscription'])
    #subscription = build_subscription(stripe_subscription)
    user = User.find_by(id: object['client_reference_id'])
    #user.subscription.interrupt if user.subscription.present?
    user.update!(stripe_id: customer.id)
  end
end
