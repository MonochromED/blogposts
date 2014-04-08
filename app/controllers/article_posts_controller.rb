class ArticlePostsController < ApplicationController
  before_action :set_article_post, only: [:show, :edit, :update, :destroy]
  # GET /article_posts
  # GET /article_posts.json
  require 'will_paginate/array' #used for combining 2 SQL request objects and paginating it properly
  def index
    @article_posts = ArticlePost.paginate(:page => params[:page], :per_page => 5).order('id desc')
    

  end

  # GET /article_posts/1
  # GET /article_posts/1.json
  def show
  end

  # GET /article_posts/new
  def new
    if (session[:user_id])
      @article_post = ArticlePost.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article_post }
      end
    else
      flash[:notice] = "Please log on to post"
      redirect_to '/article_post'
    end
  end

  # GET /article_posts/1/edit
  def edit

  end

  # POST /article_posts
  # POST /article_posts.json
  def create
    @article_post = ArticlePost.new(article_post_params)

    respond_to do |format|
      if @article_post.save
        format.html { redirect_to @article_post, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @article_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_posts/1
  # PATCH/PUT /article_posts/1.json
  def update
    if (allow_access_if_owner_name_is_or_rank_at_least("#{@article_post.poster}", 1))
      respond_to do |format|
        if @article_post.update(article_post_params)
          format.html { redirect_to @article_post, notice: 'Review was successfully updated.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @article_post.errors, status: :unprocessable_entity }
        flash[:notice] = 'You do not have permission to edit this review'

      end
    end
  end

  # DELETE /article_posts/1
  # DELETE /article_posts/1.json
  def destroy
    if (allow_access_if_owner_name_is_or_rank_at_least("#{@article_post.poster}", 1))
      @article_post.destroy
      respond_to do |format|
        format.html { redirect_to article_posts_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
      format.html { redirect_to article_posts_url }
      format.json { head :no_content }
      flash[:notice] = 'You do not have permission to delete this review'
      end
    end
  end

  def comment
    ArticlePost.find(params[:id]).comments.create(params.require(:comment).permit(:date, :poster, :comment, 
      :article_post_id))
        redirect_to :action => "show", :id => params[:id]
  end



  def delete_comment
  
    if commentToDelete = Comment.find(params[:comment_id])
      if (allow_access_if_owner_name_is_or_rank_at_least("#{commentToDelete.poster}", 1))
        commentToDelete.destroy
      else
        flash[:notice] = 'You do not have permission to edit this comment'
      end
    end
    redirect_to :action => "show", :id => params[:article_post_id]
  end



  def search
    pattern = params[:searchFor]
    pattern = "%" + pattern + "%"

    #'pattern' variable must be listed as many times as '?' is used.

    @article_posts = ArticlePost.where("title ILIKE ? OR article ILIKE ? OR poster ILIKE ?", pattern, pattern, pattern).order("id desc")
    @comments = Comment.where("comment ILIKE ? OR poster ILIKE ?", pattern, pattern).order("id desc")

    @search_results = @article_posts + @comments
    
    #paginate combined SQL returns
    @search_results = @search_results.paginate(:page => params[:page], :per_page => 5)
  end









  private
    # Use callbacks to share common setup or constraints between actions.
    # Used when selecting a particular article_post to be displayed, edited, or deleted.
    def set_article_post
      @article_post = ArticlePost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_post_params
      params.require(:article_post).permit(:title, :poster, :date, :article)
    end

 
end
