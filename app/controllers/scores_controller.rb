class ScoresController < ApplicationController
  def create
    @score = current_user.scores.build(params[:score])
    if @score.save
      @topic = @score.topic
      render :json => {partial: render_to_string(:partial => 'completed', :locals => { :score => @score }), :specific => @topic.avg_s, :actionable => @topic.avg_a, :kind => @topic.avg_k  }
    else
      render :json => render_to_string(:partial => 'failed').to_json

    end
  end
end
