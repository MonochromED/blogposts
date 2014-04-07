class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  # GET /reviews
  # GET /reviews.json
  require 'will_paginate/array' #used for combining 2 SQL request objects and paginating it properly
  def index
    #@reviews = Review.order('id desc').limit(5)
    @reviews = Review.paginate(:page => params[:page], :per_page => 5).order('id desc')
    

  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    if (session[:user_id])
      @review = Review.new
      respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
      end
    else
      flash[:notice] = "Please log on to post"
      redirect_to '/reviews'
    end
  end

  # GET /reviews/1/edit
  def edit

  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { render action: 'new' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if (allow_access_if_owner_name_is_or_rank_at_least("#{@review.poster}", 1))
      respond_to do |format|
        if @review.update(review_params)
          format.html { redirect_to @review, notice: 'Review was successfully updated.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
        flash[:notice] = 'You do not have permission to edit this review'

      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    if (allow_access_if_owner_name_is_or_rank_at_least("#{@review.poster}", 1))
      @review.destroy
      respond_to do |format|
        format.html { redirect_to reviews_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
      flash[:notice] = 'You do not have permission to delete this review'
      end
    end
  end

  def comment
    Review.find(params[:id]).comments.create(params.require(:comment).permit(:date, :poster, :comment, 
      :review_id))
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
    redirect_to :action => "show", :id => params[:review_id]
  end



  def search
    pattern = params[:searchFor]
    pattern = "%" + pattern + "%"

    #'pattern' variable must be listed as many times as '?' is used.
    #@reviews = Review.where("title LIKE ? OR article LIKE ? OR poster LIKE ?", pattern, pattern, pattern)
    #@reviews = Review.paginate(:page => params[:page], :per_page => 5).
    #where("title LIKE ? OR article LIKE ? OR poster LIKE ?", pattern, pattern, pattern)

    @reviews = Review.where("title ILIKE ? OR article ILIKE ? OR poster ILIKE ?", pattern, pattern, pattern).order("id desc")
    @comments = Comment.where("comment ILIKE ? OR poster ILIKE ?", pattern, pattern).order("id desc")

    @search_results = @reviews + @comments
    
    #paginate combined SQL returns
    @search_results = @search_results.paginate(:page => params[:page], :per_page => 5)
  end









  private
    # Use callbacks to share common setup or constraints between actions.
    # Used when selecting a particular review to be displayed, edited, or deleted.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:title, :poster, :date, :article)
    end

 
end
