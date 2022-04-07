ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    section "Recent Tasks" do
      table_for Task.order("created_at desc").limit(5) do
        column :title do |task|
          link_to task.title, [:admin, task]
        end
        column :priority
        column :completed
        column :created_at
      end
      strong { link_to "View All Tasks ", admin_tasks_path }
    end
  end 
end
