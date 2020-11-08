class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :destroy]
  
  
  def index
    @tasks = Task.order(id: :desc).page(params[:page]).per(3)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskを作成しました'
      redirect_to root_url
    else
      flash.now[:danger] = "Taskを作成できませんでした"
      render :new
    end
  end
  
  def edit
  end
  
  def update

    if @task.update(task_params)
      flash[:success] = 'Taskを更新しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskを更新できませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  

  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end