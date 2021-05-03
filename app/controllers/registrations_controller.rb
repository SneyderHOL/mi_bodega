#Placeholder for handling payments
class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    byebug
  #=begin
    resource.class.transaction do
      resource.save
      account = Account.new(account_params)
      plan = Plan.find_by(id: account.plan)
      price = Price.find_by(id: plan.price.id)
      byebug
      account.save
      yield resource if block_given?
      if resource.persisted?
        @payment = Payment.new({ token: params[:payment]["token"], user_id: resource.id })
        flash[:error] = "Please check registration errors" unless @payment.valid?
        byebug
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
        byebug
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
  #=end
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
