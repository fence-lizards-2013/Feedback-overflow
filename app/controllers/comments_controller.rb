class CommentsController < ApplicationController
  before_filter :authenticate!, :only => [:create, :edit, :destroy]
  before_filter :load_and_authorize_comment, :only => [:edit, :destroy, :update]

	def create
		comment = current_user.comments.create(params[:comment])
		topic = comment.topic
    redirect_to topic_path(topic.slug)
	end

  def edit
    @topic = @comment.topic
  end

  def update
    @comment.update_attributes(params[:comment])
    if @comment.save
      redirect_to topic_path(@comment.topic)
    else
      render :edit
    end
  end

  def destroy
    topic = @comment.topic
    @comment.destroy
    redirect_to :back
  end

  private
    def load_and_authorize_comment
      @comment = Comment.find(params[:id])
    end
end
