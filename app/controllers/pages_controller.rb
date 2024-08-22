class PagesController < ApplicationController
  def learn_more
  end

  def landing
    # Additional logic for the home page can be added here
  end

    def home
      @event = Event.new
      @recent_events = current_user.events.order(created_at: :desc).limit(5)
      @recent_uploads = Upload.order(created_at: :desc).limit(5)
    end
  end
