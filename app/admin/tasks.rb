ActiveAdmin.register Task do
  permit_params :title, :description, :priority, :completed, :completiontime

  filter :title
  filter :description
  filter :priority, as: :select, collection: Task.priorities
  filter :completed
  filter :created_at
  filter :updated_at
  filter :completiontime

  scope :all
  scope 'Recent', :recent_tasks
  scope 'Completed', :is_completed
  scope 'Pending', :is_incompleted
  scope 'Normal Priority', :priority_normal
  scope 'Medium Priority', :priority_medium
  scope 'High Priority', :priority_high


  index do
    selectable_column
    #column :id
    column :title
    column :priority
    column :created_at
    column "Completed?", :completed
    column :completiontime
    actions
  end

  controller do
    def update
      @task = Task.find(params[:id])
  
      if @task.completed == false && task_params[:completed] == "1"
        @task[:completiontime] = Time.now
        @task.save
      elsif task_params[:completed] != "1"
        @task[:completiontime] = nil
        @task.save
      end

      if @task.update(task_params)
        flash[:notice] = "Task updated successfully."
        redirect_to(admin_task_path)
      else
        flash[:error] = "Title cannot be empty and should not exceed 40 characters"
      end
    end

    def create
      @task = Task.new(task_params)
      
      if task_params[:completed] == "1"
        @task[:completiontime] = Time.now
        @task.save
      end

      if @task.save
        flash[:notice] = "Task created successfully."
        redirect_to(admin_tasks_path)
      else
        flash[:error] = "Title cannot be empty and should not exceed 40 characters"
        render('new')
      end
    end

    def task_params
      params.require(:task).permit(:title, :description , :priority, :completed)
    end
  end

  form do |f|
    f.inputs :title, :description, :completed
    f.inputs "Priority" do
      f.input :priority, as: :select, collection: Task.priorities.keys, include_blank: false, include_hidden: false
    end
    f.actions
  end
end
