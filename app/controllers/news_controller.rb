class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  # GET /news
  # GET /news.json
  require 'will_paginate/array' #used for combining 2 SQL request objects and paginating it properly
  def index
    #@news_posts = News.order('id desc').limit(5)
    #keep both here due to error when will paginate tries to pluralize @news.  @news
    #allows for the the individual posts to be displayed, while @news_posts allow for
    #pagination to function properly. 
    @news_posts = News.paginate(:page => params[:page], :per_page => 5).order('id desc')
    @news = News.paginate(:page => params[:page], :per_page => 5).order('id desc')

  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    if allowAccessIfUserRankAtLeast(1)
      @news = News.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news }
      end
    else
      flash[:notice] = "Insufficient privileges"
      redirect_to '/news'
    end
  end

  # GET /news/1/edit
  def edit

  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'news was successfully created.' }
        format.json { render action: 'show', status: :created, location: @news}
      else
        format.html { render action: 'new' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    if allowAccessIfUserRankAtLeast(1)
      respond_to do |format|
        if @news.update(news_params)
          format.html { redirect_to @news, notice: 'news was successfully updated.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
        flash[:notice] = 'You do not have permission to edit this news'

      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    if allowAccessIfUserRankAtLeast(1)
      @news.destroy
      respond_to do |format|
        format.html { redirect_to news_index_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
      flash[:notice] = 'You do not have permission to delete this news'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #used when selecting a particular news element to be displayed, edited, or deleted.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :date, :article)
    end

end
