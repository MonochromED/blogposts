class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  def index
    @comments = Comment.paginate(:page => params[:page], :per_page => 5).order('id desc')
  end


  def show

  end

  def new
    @comment = Comment.new
    respond_to do |format|
    format.html
    format.xml {render :xml => @comment}
    end
  end

  def edit
  end

  def create
      @comment = Comment.new(comment_params)

      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
          format.json { render action: 'show', status: :created, location: @comment }
        else
          format.html { render action: 'new' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end   
  end

  def update
    if allowAccessIfOwnerNameIsOrRankAtLeast( "#{@comment.poster}" , 1 )
        respond_to do |format|
          if @comment.update(comment_params)
            format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
            format.json { head :no_content }
          end
        end
      else
        respond_to do |format|
          format.html { render action: 'edit' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
          flash[:notice] = 'You do not have permission to edit this comment'

        end
    end
  end

  def destroy
    if allowAccessIfOwnerNameIsOrRankAtLeast( "#{@comment.poster}" , 1 )
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to comments_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
      format.html { redirect_to commentss_url }
      format.json { head :no_content }
      flash[:notice] = 'You do not have permission to delete this comment'
      end
    end
  end

  def destroy(commentToDelete)
    if allowAccessIfOwnerNameIsOrRankAtLeast( "#{commentToDelete.poster}" , 1 )
      commentToDelete.destroy
      respond_to do |format|
        format.html { redirect_to comments_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
      format.html { redirect_to commentss_url }
      format.json { head :no_content }
      flash[:notice] = 'You do not have permission to delete this comment'
      end
    end
  end 

  private
    def set_comment
    @comment = Comment.find(params[:id])
    end


    def comment_params
      params.require(:comment).permit(:review_id, :comment, :poster, :date)
    end
end