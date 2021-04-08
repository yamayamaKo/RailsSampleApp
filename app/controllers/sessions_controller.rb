class SessionsController < ApplicationController
  def new
  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページへ飛ぶ
      if user.activated? 
        log_in user 
        redirect_back_or user 
      else 
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message 
        redirect_back_or root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out 
    redirect_to root_url
  end 
end
