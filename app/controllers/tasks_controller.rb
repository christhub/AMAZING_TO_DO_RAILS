class TasksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @task = @list.tasks.new
  end

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(task_params)
    # binding.pry
    if @task.save
      redirect_to list_path(@task.list)
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    render :edit
  end

  def update
    # binding.pry
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if params[:mark] == "true"
      @task.update(:complete => true)
      redirect_to list_path(@list)
    elsif params[:mark] == "false"
      @task.update(:complete => false)
      redirect_to list_path(@list)
    elsif @task.update(task_params)
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @task.destroy
    redirect_to list_path(@list)
  end

  private
    def task_params
      params.require(:task).permit(:description, :complete)

    end
end
