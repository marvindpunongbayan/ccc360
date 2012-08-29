class RemindersController < ApplicationController
  
  def new
    @reminder = Reminder.new :person_id => current_person
  end

  def create
    @reminder = Reminder.new params[:reminder]
    @reminder.person_id ||= current_person.id
    @reminder.reminder_date = begin Date.strptime(params[:reminder]["reminder_date"], (I18n.t 'date.formats.default'))
                              rescue
                                nil
                              end
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
    @reminder.attributes = params[:reminder]
    @reminder.reminder_date = begin Date.strptime(params[:reminder]["reminder_date"], (I18n.t 'date.formats.default'))
                              rescue
                                nil
                              end
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
