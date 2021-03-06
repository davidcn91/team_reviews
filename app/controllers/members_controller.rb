class MembersController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
      Review.all.each do |review|
        user = User.where(email: params[:user][:email])[0]
        Vote.create(review_id: review.id, user_id: user.id)
      end
      @user = User.where(email: params[:user][:email])[0]
      UserMailer.welcome_email(@user).deliver_later
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

end
