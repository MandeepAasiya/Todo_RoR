class TasksController < ApplicationController

  def index
    #@tasks = Task.order('priority ASC')
    @tasks = Task.order(completed: :ASC, priority: :ASC)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new(:completed => false , :priority => 'Normal')
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      #flash[:notice] = "Task created successfully."
      redirect_to(tasks_path)
    else
      #flash[:error] = "Title cannot be empty and should not exceed 40 characters"
      render('new')
    end
  end

  def edit
    @task = Task.find(params[:id]) 
  end

  def update
    @task = Task.find(params[:id])

    if @task.completed == false && task_params[:completed] == "true"
      @task[:completiontime] = Time.now
      @task.save
    end

    if @task.update(task_params)
      flash[:notice] = "Task updated successfully."
      redirect_to(task_path(@task))
    else
      #flash[:error] = "Title cannot be empty and should not exceed 40 characters"
      render('edit')
    end
  end

  def delete
    @task = Task.find(params[:id])
  end
 
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    #flash[:notice] = "Task '#{@task.title}' destroyed successfully."
    redirect_to(tasks_path)
  end

  private

    def task_params
      params.require(:task).permit(:title, :description , :priority, :completed)
    end
      
end
