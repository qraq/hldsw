class SessionsController < ApplicationController

  def new
  @title = "Rejestracja"
  end
  
def create
  if current_user.nil?    
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = " niepoprawne haslo/email"
      @title = "Rejestracja"
    render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  else
    flash[:error] = "Jestes juz zalogowany!"
    redirect_to users_path
  end
end


def destroy
  sign_out
  render 'pages/home'
end



end
