class ChecklistsController < ApplicationController
  
  # Check if a user session is active
  before_action :require_user
  # Check if current_user is the owner of a checklist before editing and deleting a task
  before_action :check_owner, only: [:edit, :destroy]

  def new
    @checklist = Checklist.new
  end

  # Invoked to create a new to-do task
  def create
    @checklist = Checklist.new(checklist_params)
    @checklist.user_id = current_user.id
    @checklist.completed = false
    if @checklist.save
      redirect_to '/checklists/index'
    else
      redirect_to '/checklists/new'
      flash[:notice] = "Error saving your Task. Task name is blank or shorter than 5 characters"
    end
  end

  # Gets all the pending tasks for a user
  def index
    @checklists = Checklist.get_checklist_entries(current_user).get_pending_tasks.paginate(page: params[:page])
  end

  # Gets all the pending high priority tasks
  def hpt
    @checklists = Checklist.get_checklist_entries(current_user).get_pending_tasks.get_high_priority_tasks.paginate(page: params[:page])
  end

  # Gets all the completed tasks
  def cpt
    @checklists = Checklist.get_checklist_entries(current_user).get_completed_tasks.paginate(page: params[:page])
  end

  # Allows a user to edit a task
  def edit
    @checklist = Checklist.find(params[:format])
  end

  def show
    redirect_to '/'
  end

  def update
    checklist = Checklist.find(params[:id])
    checklist.task_name = params[:checklist][:task_name]
    checklist.priority = params[:checklist][:priority]
    checklist.notes = params[:checklist][:notes]
    if checklist.save
      flash[:notice] = "Record updated successfully"
    else
      flash[:notice] = "Something went wrong!"
    end
    redirect_to '/'
  end

  # Deletes a task from the system
  def delete
    Checklist.find(params[:format]).destroy
    flash[:notice] = "Delete successful"
    redirect_to '/'
  end

  # Performs the owner check
  def check_owner
    if current_user != Checklist.find(params[:format]).user
      flash[:notice] = "Trying to be cheeky are we? You cannot modify a task that's not yours!"
      redirect_to '/'
    end
  end

  # If a task is complete, this function re-opens it and if a task is incomplete, this markes the task as complete.
  def switch
    @checklist = Checklist.find(params[:format])
    if @checklist.update_attribute(:completed, !@checklist.completed)
      flash[:notice] = "Status change successful"
    else
      flash[:notice] = "Something went wrong"
    end
    redirect_to '/'
  end


  private

  # Used for building a task from user's form input
  def checklist_params
    params.require(:checklist).permit(:task_name, :priority, :notes, :completed)
  end

end
