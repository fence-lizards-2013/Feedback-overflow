class TopicsController < ApplicationController
  before_filter :load_and_authorize_topic, :only => [:edit, :update, :destroy]

  def index
    @topics = Topic.find(:all, :order => 'upvotes_count DESC')
    @recent_topic = Topic.last
  end

  def new
    @topic = Topic.new
  end

  def show
    @topic = Topic.find_by_slug(params[:id])
    @comment = Comment.new
    @score = Score.where(user_id: current_user.id, topic_id: @topic.id).first_or_initialize if signed_in?# IF user hasn't left Score yet otherwise show graph
    @graph = LazyHighCharts::HighChart.new('column') do |f|
      f.series( :name=>'Scores',:data=> [@topic.avg_s, @topic.avg_a, @topic.avg_k], :shadow => true, :borderWidth => 0, :color => "#0e9896")
      f.options[:chart][:defaultSeriesType] = "column"
      f.options[:chart][:backgroundColor] = "#ecf0f1"
      f.xAxis(categories: ['Specific', 'Actionable', 'Kind'])
      f.yAxis(min: 1, max: 5, title: nil, labels: false, gridLineWidth: 0)
      f.legend(enabled: false)
      f.options[:series]
    end
  end

 def edit
 end

 def create
  @topic = current_user.topics.build(params[:topic])
  if @topic.save
    redirect_to topic_path(@topic)
  else
    render :new
  end
end

def update
  @topic.update_attributes(params[:topic])
  if @topic.save
    flash[:success] = "Topic has been successfully updated!"
    redirect_to topic_path
  else
    render :edit
  end
end

  def destroy
    p '*' * 1000
    @topic.comments.destroy_all
    @topic.scores.destroy_all
    @topic.destroy
    redirect_to root_url
  end

  private
    def load_and_authorize_topic
      @topic = Topic.find_by_slug(params[:id])
      redirect_to root_path unless @topic.created_by?(current_user)
    end

end
