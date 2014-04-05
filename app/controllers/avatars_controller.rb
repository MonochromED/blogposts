class AvatarsController < ApplicationController
  before_action :set_avatar, only: [:show, :edit, :update, :destroy]
  def index
    @avatars = Avatar.paginate(:page => params[:page], :per_page => 5).order('id desc')
  end


  # GET /avatar/1
  # GET /avatar/1.json
  def show
  end

#fix all this so that CRUD works with the Avatar class object and database

  # GET /avatar/new
  def new
    if (session[:user_id])
      @avatar = Avatar.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @avatar }
      end
    else
      flash[:notice] = "Please log on to post"
      redirect_to '/avatar'
    end
  end

  # GET /avatar/1/edit
  def edit
  end

  # POST /avatar
  # POST /avatar.json
  def create
    @avatar = Avatar.new(avatar_params)

    respond_to do |format|
      if @avatar.save
        format.html { redirect_to @avatar, notice: 'Avatar was successfully created.' }
        format.json { render action: 'show', status: :created, location: @avatar }
      else
        format.html { render action: 'new' }
        format.json { render json: @avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avatar/1
  # PATCH/PUT /avatar/1.json
  def update
    respond_to do |format|
      if @avatar.update(avatar_params)
        format.html { redirect_to @avatar, notice: 'Avatar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avatar/1
  # DELETE /avatar/1.json
  def destroy
    @avatar.destroy
    respond_to do |format|
      format.html { redirect_to avatar_url }
      format.json { head :no_content }
    end
  end






  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avatar
      @avatar = Avatar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def avatar_params
      params.require(:avatar).permit(:avatar_user_id, :avatar_file_name, :avatar_content, :avatar_file_size, :avatar)
    end

end
