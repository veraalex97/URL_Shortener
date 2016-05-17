class UrlShortenerController < ApplicationController
before_action :clean_params, only: [:create]

  def index
    @new_url = UrlShortener.new

  end

  def show
    @url_found = UrlShortener.find_by(small_url: params[:small_url])

    if @url_found
      if @url_found.original_url.include? "http"
        redirect_to @url_found.original_url
      else
        @url_found = @url_found.original_url
        @url_found.prepend("http://")
        redirect_to @url_found
      end
    else
      redirect_to root_path
    end

  end

  def create
    @new_url = UrlShortener.new(clean_params)
    @new_url.save
    @user_last_url = UrlShortener.last
    # redirect_to create_path
  end


  private
    def clean_params
      #require for table name permit that value from form (table column)
      params.require(:url_shortener).permit(:original_url, :small_url)
    end
end
