class FollowRequestsController < ApplicationController
  def index
    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_follow_requests = FollowRequest.where({ :id => the_id })

    @the_follow_request = matching_follow_requests.at(0)

    render({ :template => "follow_requests/show.html.erb" })
  end

  def create
    the_follow_request = FollowRequest.new
    the_follow_request.recipient_id = params.fetch("input_recipient")
    the_follow_request.sender_id = params.fetch("input_sender")
    
    
    if User.where({:id => params.fetch("input_recipient")}).at(0).private == false
    
    the_follow_request.status = "accepted"
    else
      the_follow_request.status = "pending"
    end

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/users", { :notice => "Follow request created successfully." })
    else
      redirect_to("/users", { :alert => the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.status = params.fetch("query_status")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/users/#{@current_user.username}", { :notice => "Follow request updated successfully."} )
    else
      redirect_to("/follow_requests/#{the_follow_request.id}", { :alert => the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_following_id = FollowRequest.where({ :id => the_id }).at(0).recipient_id
    the_following_username = User.where({ :id => the_following_id }).at(0).username
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to("/users/#{the_following_username}", { :notice => "Follow request deleted successfully."} )
  end

  def unfollow
    the_id = params.fetch("path_id")
    the_following = FollowRequest.where({ :id => the_id }).at(0).recipient_id
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to("/users/#{the_following}")
    
  end


end
