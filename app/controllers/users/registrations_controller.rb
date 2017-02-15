class Users::RegistrationsController < Devise::RegistrationsController
  include ActionView::Helpers::TagHelper
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  def new_student
    @disable = true
    session[:user] ||= { }
    session[:user]['instructor'] = false
    session[:user]['student'] = true
    @user = build_resource(session[:user])
  end

  def new_instructor
    @disable = true
    session[:user] ||= { }
    session[:user]['instructor'] = true
    session[:user]['student'] = false
    @user = build_resource(session[:user])
  end

  # POST /resource
  def create

    @user = build_resource(sign_up_params)

    if params[:instructor_button]
      @user.instructor = true
      @user.student = false
      @user.save

    elsif params[:student_button]
      @user.instructor = false
      @user.student = true
      @user.save
    end

    yield resource if block_given?
    if @user.persisted?

      # We know that the user has been persisted to the database, so now we can create our empty profile

      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(:user, @user)
        redirect_to root_path
      else
        set_flash_message! :notice, :"signed_up_but_#{@user.inactive_message}"
        expire_data_after_sign_in!
        redirect_to root_path
      end
    else
      clean_up_passwords @user
      set_minimum_password_length
      redirect_to :back
      # binding.pry
      # flash[:notice] =
      resource.errors.messages.each do |msg|
        # { |msg| msg.to_s }.join
        flash[msg[0]] = msg[1].to_s
      end
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :first_name, :last_name, :access_code])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :first_name, :last_name, :access_code])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
