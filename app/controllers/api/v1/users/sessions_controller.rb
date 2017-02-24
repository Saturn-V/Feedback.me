class Api::V1::Users::SessionsController < Devise::SessionsController
before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  def create
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
