class BillingPortalController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :validate_permissions, only: [:create]
  before_action :get_customer_id, only: [:create]

  def create
    if @customer_id
      portal_session = Stripe::BillingPortal::Session.create({
        customer: @customer_id,
        return_url: root_url
      })
      redirect_to portal_session.url
    end
  end

  private

  def get_customer_id
    @customer_id ||= Payment.where(user: current_user).first&.stripe_customer_id
  end
end
