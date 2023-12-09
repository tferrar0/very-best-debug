class UsersController < ApplicationController

  def index
    matching_users = User.all
    @users = matching_users.order(:created_at)

    render({ :template => "user_templates/index"})
  end
  
  def show
    url_username = params.fetch("path_username")
    matching_users = User.where({ :username => url_username })
    @user = matching_users.at(0)

    render({ :template => "user_templates/user_details"})
  end
  
  def create
    input_user = params.fetch("query_username")
    
    a_new_user = User.new
    a_new_user.username = input_user
    a_new_user.save
    
    redirect_to("/users/#{a_new_user.username}")
  end
  
  def update
    user_id = params.fetch("user_id")
    input_username = params.fetch("query_username")

    matching_users = User.where({ :id => user_id })
    the_user = matching_users.at(0)
    
    the_user.username = input_username
   
    the_user.save
    redirect_to("/users/#{the_user.username}")
  end

end
