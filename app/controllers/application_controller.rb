class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def getUserInfo(userInfo = nil)
    userInfo = User.find_by userid: "#{userInfo}"
    if (userInfo != nil)
      userInfo
    else
      nil
    end
  end

  def validate
  
    respond_to do |format|
      user = User.authenticate(params[:userid], params[:password])
      if user
        session[:user_id] = user.userid
        flash[:notice] = 'User successfully logged in'
      else
        flash[:notice] = 'Invalid user/password'
      end
      if session[:return_to_page] === nil
        format.html {redirect_to "/reviews"}
      else
      format.html {redirect_to "#{session[:return_to_page]}" }
      end
    end  
  end

  def logout
    
    respond_to do |format|
      session.delete(:user_id)
      flash[:notice] = 'User successfully logged out'
      format.html {redirect_to '/reviews' }
    end
  end

  def getUser
    user = session[:user_id]
    user
  end


  def search
    pattern = params[:searchFor]
    pattern = "%" + pattern + "%"

    #'pattern' variable must be listed as many times as '?' is used.
    #@reviews = Review.where("title LIKE ? OR article LIKE ? OR poster LIKE ?", pattern, pattern, pattern)
    @reviews = Review.paginate(:page => params[:page], :per_page => 5).
    where("title LIKE ? OR article LIKE ? OR poster LIKE ?", pattern, pattern, pattern)
  end

  def belongsToCurrentUser(userid)
    if session[:user_id] === userid
      true
    else
      false
    end
  end

  #Returns the access rank of the current user
  def getAccessRank
    guest_user_rank = 4
    user = getUser()
    if user != nil
      current_user = User.find_by userid: "#{user}"
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
  def allowAccessIfUserRankAtLeast(access_rank_value)
    user_rank = getAccessRank()
    if user_rank <= access_rank_value
      true
    else
      false
    end
  end


  #Checks if user has sufficient rank or if user is owner. Returns boolean
  def allowAccessIfOwnerNameIsOrRankAtLeast(entity_owner, access_rank_value)
    if ( belongsToCurrentUser(entity_owner) || 
      allowAccessIfUserRankAtLeast(access_rank_value) )
      true
    else
      false
    end

  end

  #Checks if user is registered user.
  def userIsLoggedIn()
    user = getUser()
    if user != nil
      true
    else
      false
    end
  end

  #returns “currentPageLinkHighlight” as string if 
  #current page matches the argument path or if
  #current page is a subdirectory of the argument path.
  def linkMatchesCurrentPage(path)
    if request.fullpath === path
      "currentPageLinkHighlight" 
    elsif request.fullpath.match("#{path}")
      "currentPageLinkHighlight"
    end 
  end 

end

