class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5).order('id desc')
  end


  # GET /user/1
  # GET /user/1.json
  def show
  end

#fix all this so that CRUD works with the User class object and database

  # GET /users/new
  def new 

  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #Clear out current user session login before delete
    user_to_be_deleted = @user.userid
    if belongsToCurrentUser(user_to_be_deleted)
      session[:user_id] = nil
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
      flash[:notice] = "#{user_to_be_deleted}" + 
      "'s account has been terminated"
    end
  end


  #default registered user access level is 3, unregistered is 4, 1 is admin, 2 is moderator
  def newuser
    respond_to do |format|
      user = User.new
      user.userid = params[:userid]
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.password_hash = params[:password_hash]
      user.password_salt = params[:password_salt]
      user.fullname = params[:fullname]
      user.email = params[:email]
      user.access_rank = 3
      if user.save
        session[:user_id] = user.userid
        flash[:notice] = 'New User ID was successfully created.'
        format.html {redirect_to '/reviews' }
      elsif user.password != user.password_confirmation
        flash[:notice] = 'Sorry, your password and password confirmation does not match.'
        format.html {redirect_to '/users/register' }            
      else
        flash[:notice] = 'Sorry, User ID already exists.'
        format.html {redirect_to '/users/register' } 
      end


    end
  end


  def updateProfileInfo

    userInfo = getUserInfo(params[:userIdToEdit])

    if userInfo != nil
      userInfo.email = params[:emailupdate]   
      userInfo.save
    else
      nil
    end

        redirect_to userprofile_users_path
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:userid, :password, :password_confirmation, :fullname, :email)
    end

end

