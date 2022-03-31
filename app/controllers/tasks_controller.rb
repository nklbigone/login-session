class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :current_user
  skip_before_action :login_required, only: [:new, :create]
  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'You have registered a task' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if current_user.id != @task.user_id
      flash[:notice] = "Not Allowed!"
      redirect_to tasks_path(session[:task_user])
      return
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'The task has been updated'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task has been deleted'
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content)
    end
end
