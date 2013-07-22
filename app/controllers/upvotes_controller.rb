class UpvotesController < ApplicationController
  before_filter :authenticate!

  def create
    @topic = Topic.find_by_slug(params[:format])
    upvote = @topic.upvotes.build(user_id: current_user.id)
    if upvote.save
      render :json => {:count => @topic.reload.upvotes_count }, :status => :ok
    else
      @topic.upvotes.find_by_user_id(current_user.id).destroy
      render :json => {:count => @topic.reload.upvotes_count }, :status => :ok
    end
  end

end
