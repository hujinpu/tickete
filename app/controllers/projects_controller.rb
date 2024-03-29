class ProjectsController < ApplicationController

  before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :authenticate_user!, :only => [:index, :show]
  before_filter :find_project, :only => [:show,
                                         :edit,
                                         :update,
                                         :destroy]

  def index
    @projects = Project.for(current_user).all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:alert] = "Project has not been created."
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @project.delete
    flash[:notice] = "Project has been deleted."
    redirect_to projects_path
  end

  private
  def find_project
    @project = Project.for(current_user).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking" +
        " for could not be found."
    redirect_to projects_path
  end
end
