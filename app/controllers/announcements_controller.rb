class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  # GET /announcements
  # GET /announcements.json
  require 'will_paginate/array' #used for combining 2 SQL request objects and paginating it properly
  def index
    @announcements = Announcement.paginate(:page => params[:page], :per_page => 5).order('id desc')


  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  # GET /announcements/new
  def new
    if allow_access_if_user_rank_at_least(1)
      @announcement = Announcement.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @announcement }
      end
    else
      flash[:notice] = "Insufficient privileges"
      redirect_to '/announcements'
    end
  end

  # GET /announcements/1/edit
  def edit

  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement}
      else
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    if allow_access_if_user_rank_at_least(1)
      respond_to do |format|
        if @announcement.update(announcement_params)
          format.html { redirect_to @announcement, notice: 'announcements was successfully updated.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
        flash[:notice] = 'You do not have permission to edit this announcement.'

      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    if allow_access_if_user_rank_at_least(1)
      @announcement.destroy
      respond_to do |format|
        format.html { redirect_to announcements_index_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
      format.html { redirect_to announcements_index_url }
      format.json { head :no_content }
      flash[:notice] = 'You do not have permission to delete this announcement'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #used when selecting a particular announcements element to be displayed, edited, or deleted.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:title, :date, :article)
    end

end
