class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
    respond_to :json

    def create
      @user = build_resource(sign_up_params)

      if @user.persisted?

        # We know that the user has been persisted to the database, so now we can create our empty profile

        if resource.active_for_authentication?
          sign_up(:user, @user)
          render :json => {:user => @user}
        else
          expire_data_after_sign_in!
          render :json => {:message => 'signed_up_but_#{@user.inactive_message}'}
        end
      else
        if params[:user][:email].nil?
          render :status => 400,
          :json => {:message => 'User request must contain the user email.'}
          return
        elsif params[:user][:password].nil?
          render :status => 400,
          :json => {:message => 'User request must contain the user password.'}
          return
        end

        if params[:user][:email]
          duplicate_user = User.find_by_email(params[:email])
          unless duplicate_user.nil?
            render :status => 409,
            :json => {:message => 'Duplicate email. A user already exists with that email address.'}
            return
          end
        end

        render :status => 400,
        :json => {:message => resource.errors.full_messages}
      end
    end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :first_name, :last_name])
    end

end
