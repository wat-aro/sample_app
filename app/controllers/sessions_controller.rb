# class SessionsController < ApplicationController
#   def new
#   end

#   def create
#     user = User.find_by(email: params[:session][:email].downcase)
#     if user && user.authenticate(params[:session][:password])
#       if user.activated?
#         log_in user
#         params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#         redirect_back_or user
#       else
#         message = t('flash.account_not_activated')
#         message += t('flash.check_your_email_for_the_activation_link')
#         flash[:warning] = message
#         redirect_to root_url
#       end
#     else
#       flash.now[:danger] = t('flash.invalid_email_password_combination')
#       render 'new'
#     end
#   end

#   def destroy
#     log_out if logged_in?
#     redirect_to root_url
#   end
# end
