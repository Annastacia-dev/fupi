class UrlsController < ApplicationController

  def new
    @new_url = Url.new
  end

  def create
    existing_url = Url.find_by(original: url_params[:original])
    if existing_url
      @url = existing_url
      render :new
    else
      @new_url = Url.new(url_params)
      if @new_url.save
        @url = @new_url
        render :new
      else
        render :new
      end
    end
  end

  def redirect
    @url = Url.find_by(shortened: params[:short_url]) || Url.find_by(custom_alias: params[:short_url])
    if @url.present?
      redirect_to @url.original, allow_other_host: true
    else
      redirect_to root_path, notice: 'Link not found'
    end
  end

  private

  def url_params
    params.require(:url).permit(:original, :custom_alias)
  end
end
