# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :customer_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


  def after_sign_in_path_for(public)
    public_customer_path(current_customer)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
        # パスワードが正しく、かつ無効である場合、新しいユーザーセッションのパスにリダイレクトします。
        redirect_to new_customer_session_path
      end
    end
  end
end
