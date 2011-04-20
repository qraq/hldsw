class SessionsController < ApplicationController

  def new
  @title = "Sign in"
  end
  
def create
  if current_user.nil?    
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = " invalid pass/email"
      @title = "Sing in"
    render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  else
    flash[:error] = "U are already loged in!"
    redirect_to users_path
  end
end


def destroy
  sign_out
  render 'pages/home'
end



end
