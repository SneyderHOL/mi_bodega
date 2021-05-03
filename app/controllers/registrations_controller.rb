#Placeholder for handling payments
class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.class.transaction do
      resource.save
      account = Account.new(account_params)
      plan = Plan.find_by(id: account.plan)
      price = Price.find_by(id: plan.price.id)
      account.save
      purchase_plan = plan.name.downcase == 'moderate' || plan.name.downcase == 'unlimited'
      yield resource if block_given?
      if resource.persisted?
        @payment = Payment.new({ token: params[:payment]["token"], user_id: resource.id })
        unless @payment.valid?
          flash[:error] = "Please check registration errors"
          return
        end
        if purchase_plan
          begin
            @payment.payment_process(resource.email, price, account)
            @payment.save
            new_acount = AccountUser.create(user: resource, account: account, admin: true)
          rescue Exception => e
            flash[:error] = e.message
            account.destroy
            resource.destroy
            puts 'Payment failed'
            render :new and return
          end
        else
          Subscription.create(
            price: price,
            account: account,
            active: true
          )
        end
        
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end

  protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_up).push(:payment)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:payment])
  end

  def account_params
    params.require(:account).permit(:name, :plan)
  end
end
