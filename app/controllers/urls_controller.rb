class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.shortened = SecureRandom.urlsafe_base64(6)

    if @url.save
      render :new
    else
      render :new
    end
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
