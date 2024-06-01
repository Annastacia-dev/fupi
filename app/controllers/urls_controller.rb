class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    byebug
    @url = Url.new(url_params)
    @url.shortened = SecureRandom.urlsafe_base64(6)

    if @url.save
      render :new
    else
      render :new
    end
  end

  def redirect
    @url = Url.find_by(shortened: params[:short_url])
    if @url.present?
      redirect_to @url.original, allow_other_host: true
    else
      redirect_to root_path, notice: 'Link not found'
    end
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
