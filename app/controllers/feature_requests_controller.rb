class FeatureRequestsController < ApplicationController
  def new
    @feature_request = FeatureRequest.new
  end

  def create
    @feature_request = FeatureRequest.new(feature_request_params)
    if @feature_request.save
      redirect_to feature_requests_path, notice: 'Feature request submitted successfully.'
    else
      render :new
    end
  end

  def index
    @feature_requests = FeatureRequest.all
  end

  private

  def feature_request_params
    params.require(:feature_request).permit(:title, :description)
  end
end
