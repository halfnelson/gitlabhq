class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    info = request.env["omniauth.auth"]["info"]
    @user = User.find_for_google_auth(info)
    if @user.nil?
      flash[:notice] = "No user found for #{info.email}"
      redirect_to root_path
    else
      sign_in_and_redirect @user
    end

   end

  def ldap
    # We only find ourselves here if the authentication to LDAP was successful.
    info = request.env["omniauth.auth"]["info"]
    @user = User.find_for_ldap_auth(info)
    if @user.persisted?
      @user.remember_me = true
    end
    sign_in_and_redirect @user
  end

end
