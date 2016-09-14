class TasksController < ApplicationController
  def index
    @list = List.includes(:tasks).find(params[:list_id])
    @tasks = @list.tasks.order("created_at DESC")
    @task = Task.new
  end
end
