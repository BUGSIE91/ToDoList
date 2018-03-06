class ChecklistsController < ApplicationController
  
  before_action :require_user
  before_action :check_owner, only: [:edit, :delete]

  def new
    @checklist = Checklist.new
  end

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

  def index
    @user_checklists = Checklist.get_checklist_entries(current_user)
  end

  def edit
    @checklist = Checklist.find(params[:format])
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

  def delete
    Checklist.find(params[:format]).destroy
    redirect_to '/'
  end

  def show
    redirect_to '/'
  end

  def check_owner
    if current_user != Checklist.find(params[:format]).user
      flash[:notice] = "Trying to be cheeky are we? You cannot modify a task that's not yours!"
      redirect_to '/'
    end
  end


  private

  def checklist_params
    params.require(:checklist).permit(:task_name, :priority, :notes, :completed)
  end

end
