# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :user_registration_paramns, only: [:create, :update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    @user = User.new({:name => user_registration_paramns[:name], :email => user_registration_paramns[:email], :password => user_registration_paramns[:password]})
    if @user.save
      flash[:success] = "Sign up successfully"
      redirect_to root_path
    else
      flash[:danger] = "Can't sign up"      
      redirect_to new_user_registration_path
    end    
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    if @user.valid_password?(user_registration_paramns[:password])
      if @user.update({:contact => user_registration_paramns[:contact]})
        image_params = {avatar: user_registration_paramns[:user_image_attributes][:picture]}
        image = @user.build_image(image_params)
        if image.save
          flash[:success] = "User profile successfully updated"
          redirect_to root_path
        else
          flash[:danger] = "Can't update profile"      
          redirect_to edit_user_registration_path  
        end
      else
        flash[:danger] = "Can't update profile"
        redirect_to edit_user_registration_path
      end
    else
      flash[:danger] = "Can't update profile"
      redirect_to edit_user_registration_path
    end
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

  protected

  def user_registration_paramns
    params.require(:user).permit(:email, :name, :password, :contact, user_image_attributes: [:picture])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(new_user_session_path)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
