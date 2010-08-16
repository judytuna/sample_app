class UsersController < ApplicationController
  def new
    @title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name  # but a cross-site scripting attack could be injected
                         #into our app by the title helper here, so we escape
                         #it by using the h method in helpers/application_helper.rb
  end
end
