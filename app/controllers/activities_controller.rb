class ActivitiesController < ApplicationController
  before_action :set_type
  before_action :set_activity, only: [:show, :edit, :destroy, :complete, :activity_tr]
  before_action :activity_data, only: [:index, :display]

  def index
    @goal= Goal.find_by(id: params[:goal_id])
  end

  def show
  end

  def edit
  end

  def update
    activity = Activity.find_by(id: params[:id])
    activity.date= params[:date]
    activity.duration= params[:duration]
    activity.description= params[:description]
    activity.complete= true
    activity.save
    render :nothing => true
  end

  def destroy
    @activity.destroy
    redirect_to activities_url
  end

  def new
    @goal= Goal.find_by(id: params[:goal_id])
    @week= Week.find_by(id: params[:week_id])
    @activity = type_class.new
  end

  def create
    @goal= Goal.find_by(id: params[:goal_id])
    @week= Week.find_by(id: params[:week_id])
    @activity = @week.activities.new(activity_params)

    if @activity.save
      redirect_to goal_week_activities_path(@goal.id, @week.id), notice: "#{type} was successfully created."
    else
      render action: 'new'
    end
  end

  def activity_tr
    render partial: 'activity_tr', locals: {activity: @activity}
  end

  def display
   render partial: "activities_display", locals: {activities_not_complete: @activities_not_complete, activities_complete: @activities_complete}
  end

  private
    def set_activity
     @activity = type_class.find(params[:id])
    end

    def set_type
      @type = type
    end

    def type
      Activity.types.include?(params[:type]) ? params[:type] : "Activity"
    end

    def type_class
      type.constantize
    end

    def activity_params
      params.require(type.underscore.to_sym).permit(:type, :week_id)
    end

    def activity_data
      @week = Week.find_by(id: params[:week_id])
      @activities_complete = Activity.all.where(:week_id => @week.id, :complete => true)
      @activities_not_complete = Activity.all.where(:week_id => @week.id, :complete => false)
    end
end
