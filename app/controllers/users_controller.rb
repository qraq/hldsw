class UsersController < ApplicationController
  
  
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  def destroy 
    User.find(params[:id]).destroy
    flash[:success] = "Uzytkownik skasowany!"
    redirect_to users_path
    
  end
  
  
  def index
    @title = "Wszyscy uzytkownicy"
    @users = User.all
    @sorted_users = User.find(:all, :order => sort_order('points'))
   
  end
  
  def new
    if current_user.nil?  
      @user = User.new
      @title = "Sign up"
    else 
      redirect_to current_user
    end  
  end


  def show
    @user = User.find(params[:id])
  end


  def create
    if current_user.nil?     
  
      @user = User.new(params[:user])
      @user.points = 0
      @user.death = 0
      if @user.save
        sign_in @user
        flash[:success] = "Witaj w HLDS-Web!"
        redirect_to @user
      else
        @title = "Sign up"
        @user.password =""
        render 'new'
      end
    else
     redirect_to current_user
    end
 end
 
 
  
  def edit
  
    @title = "edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil zaktualizowany."
      redirect_to @user
    else
    @title = "Edytycja profilu"
    render 'edit'
    end
    
    
   end

    


private
  def authenticate
    deny_access unless signed_in?
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirec_to(root_path) unless current_user.admin?
  end
end
