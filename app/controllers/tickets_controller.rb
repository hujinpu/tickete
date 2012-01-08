class TicketsController < ApplicationController

  before_filter :find_project
  before_filter :find_ticket, :only => [:show,
                                        :edit,
                                        :update,
                                        :destroy]

  def new
    # the same to: Ticket.new(:project_id => @project.id)
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(params[:ticket])
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render :action => "new"
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The ticket you were looking" +
        " for could not be found."
    redirect_to project_tickets_path
  end
end
