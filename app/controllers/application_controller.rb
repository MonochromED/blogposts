class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def get_user_info(user_info = nil)
    user_info = User.find_by user_id: "#{user_info}"
    if (user_info != nil)
      user_info
    else
      nil
    end
  end

  def validate
  
    respond_to do |format|
      user = User.authenticate(params[:user_id], params[:password])
      if user
        session[:user_id] = user.user_id
        flash[:notice] = 'User successfully logged in'
      else
        flash[:notice] = 'Invalid user/password'
      end
      if session[:return_to_page] === nil
        format.html {redirect_to "/article_posts"}
      else
      format.html {redirect_to "#{session[:return_to_page]}" }
      end
    end  
  end

  def logout
    
    respond_to do |format|
      session.delete(:user_id)
      flash[:notice] = 'User successfully logged out'
      format.html {redirect_to '/article_posts' }
    end
  end

  def get_user
    user = session[:user_id]
    user
  end


  def search
    pattern = params[:searchFor]
    pattern = "%" + pattern + "%"

    @article_posts = ArticlePost.paginate(:page => params[:page], :per_page => 5).
    where("title LIKE ? OR article LIKE ? OR poster LIKE ?", pattern, pattern, pattern)
  end

  def belongs_to_current_user(user_id)
    if session[:user_id] === user_id
      true
    else
      false
    end
  end

  #Returns the access rank of the current user
  def get_access_rank
    guest_user_rank = 4
    user = get_user()
    if user != nil
      current_user = User.find_by user_id: "#{user}"
      user_rank = current_user.access_rank

      #Handler if user access rank missing
      if user_rank === nil
        flash[:notice] = "Problem getting user access level.
        Please contact site administrator."
        user_rank = guest_user_rank
      end

      user_rank

    else
      user_rank = guest_user_rank
    end
  end
  

  #Checks current user rank against argument value.  Returns boolean
  def allow_access_if_user_rank_at_least(access_rank_value)
    user_rank = get_access_rank()
    if user_rank <= access_rank_value
      true
    else
      false
    end
  end


  #Checks if user has sufficient rank or if user is owner. Returns boolean
  def allow_access_if_owner_name_is_or_rank_at_least(entity_owner, access_rank_value)
    if ( belongs_to_current_user(entity_owner) || 
      allow_access_if_user_rank_at_least(access_rank_value) )
      true
    else
      false
    end

  end

  #Checks if user is registered user.
  def user_is_logged_in()
    user = get_user()
    if user != nil
      true
    else
      false
    end
  end

  #returns “currentPageLinkHighlight” as string if 
  #current page matches the argument path or if
  #current page is a subdirectory of the argument path.
  def link_matches_current_page(path)
    if request.fullpath === path
      "currentPageLinkHighlight" 
    elsif request.fullpath.match("#{path}")
      "currentPageLinkHighlight"
    end 
  end 

end

