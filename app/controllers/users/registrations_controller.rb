class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  def new_student
    session[:user] ||= { }
    session[:user]['instructor'] = true
    session[:user]['student'] = false
    @user = build_resource(session[:user])
  end

  def new_instructor
    session[:user] ||= { }
    session[:user]['instructor'] = true
    session[:user]['student'] = false
    @user = build_resource(session[:user])
    @user.current_step = "teacher"
  end

  # POST /resource
  def create
    session[:user].deep_merge!(params[:user]) if params[:user]
    @user = build_resource(session[:user])
    @user.current_step = session[:registration_step]

    if @user.valid?
      if @user.teacher_step || @user.student_step
        @user.save if @user.valid?
      else
        @user.next_step
      end
      session[:registration_step] = @user.current_step
    end

    if @user.new_record?
      render 'new'
    else
      session[:user_params] = nil

      if @user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(:user, @user)
        respond_with @user, :location => after_sign_up_path_for(@user)
      else
        set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @user, :location => after_inactive_sign_up_path_for(@user)
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
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
