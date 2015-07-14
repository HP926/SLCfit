class GoalsController < ApplicationController
  before_action :find_user
  before_action :find_goal, only: [:edit, :show, :update, :create, :destroy]

  def index
    @goals = Goal.where(user_id: current_user.id)
  end

  def show
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      flash[:notice] = "Your goal was successfully updated!"
      redirect_to(goals_path)
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
        @goal.time_frame.times do
          week = @goal.weeks.new
          week.save
        end
      flash[:notice] = "Your goal was successfully created!"
      redirect_to(goals_path)
    end
  end

  def destroy
    @goal.destroy
    respond_to do |format|
    format.html { redirect_to goals_path, notice: 'Item was successfully destroyed.' }
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:user_id, :description, :reason, :time_frame, :complete)
  end

  def find_goal
    @goal = Goal.find_by(id: params[:id])
    #  unless @goal
    #    render (text: 'goal not found', status: 404)
    #  end
  end

  def find_user
    @user = current_user
  end

end
