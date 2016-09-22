class TasksController < ApplicationController

  def index
    @list = List.includes(:tasks).find_by(id: params[:list_id])
    @tasks = @list.tasks.order("created_at DESC")
    @task = Task.new
    @incompleted_task = Task.where(completed: false)
    @completed_task = Task.where(completed: true)
  end

  def new
    @task = Task.new
    @list = List.find_by(id: params[:list_id])
  end

  def create
    @list = List.find_by(id: params[:list_id])
    @task = Task.new(task_params.merge(list_id: params[:list_id]))

    if @task.save
      flash.now[:success] = "New task created."
      redirect_to list_tasks_path(@list)
    else
      flash.now[:danger] = @task.errors.full_messages
      redirect_to new_list_task_path(@list)
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    @list = @task.list
  end

  def update
    @task = Task.find_by(id: params[:id])
    @list = List.find_by(id: params[:list_id])

    if @task.update(task_params)
      flash[:success] = "Updated task."
      redirect_to list_tasks_path(@list, @task)
    else
      flash[:danger] = @task.errors.full_messages
      redirect_to edit_list_task_path(@list, @task)
    end
  end

  def completed

    @task = Task.find_by(id: params[:task_id])
    @list = List.find_by(id: params[:list_id])

    if @task.update_attribute(:completed, true)
    flash[:success] = "Task completed"
    redirect_to list_tasks_path(@list, @task)
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @list = @task.list

    if @task.destroy
      flash[:success] = "Deleted task."
      redirect_to list_tasks_path(@list)
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :completed)
  end

end
