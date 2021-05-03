class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
  
  belongs_to :user
  
  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i + 1} - #{name}", i+1] }
  end

  def self.year_options
    (Date.today.year .. (Date.today.year + 10)).to_a
  end

  def payment_process(email, price, account)
    customer = Stripe::Customer.create email: email, card: token
    # subscription here
    subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [
        {
          price: price.stripe_price_id,
          quantity: 1
        },
      ],
    })
    self.stripe_customer_id = customer.id
    subscription_register = Subscription.new(price: price, account: account, active: true)
    byebug  
    subscription_register.save
    byebug
  end
end
