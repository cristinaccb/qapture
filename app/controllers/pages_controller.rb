class PagesController < ApplicationController
  def learn_more
  end

  def landing
    # Additional logic for the home page can be added here
  end

  def home
    @recent_events = Event.order(created_at: :desc).limit(5)
    @recent_uploads = Upload.order(created_at: :desc).limit(10)
  end

end
