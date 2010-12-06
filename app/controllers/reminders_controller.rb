class RemindersController < ApplicationController
  def new
    @reminder = Reminder.new :person_id => current_person
  end

  def create
    @reminder = Reminder.new params[:reminder]
    @reminder.person_id ||= current_person.id
    if @reminder.save
    else
      render :action => :new
    end

  end

  def edit
    @reminder = Reminder.find params[:id]
  end

  def update
    @reminder = Reminder.find params[:id]
    @reminder.update_attributes params[:reminder]
    if @reminder.save
    else
      render :action => :new
    end
  end

  def destroy
    @reminder = Reminder.find params[:id]
    @reminder.destroy
  end
end
