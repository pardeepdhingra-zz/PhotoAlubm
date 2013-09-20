class PicturesController < ApplicationController
  before_filter :get_album
	
  def index
    @pictures = @album.pictures
    render :json => @pictures.collect { |p| p.to_jq_upload }.to_json
  end

  def new
    @object_new = @album.pictures.new    # needed for form_for --> gets the path
  end

  def create
    @picture = @album.pictures.new
    @picture.avatar = params[:picture][:path].shift
	@picture.title = params[:picture][:title]
    if @picture.save
      respond_to do |format|
        format.html {                                         #(html response is for browsers using iframe sollution)
          render :json => [@picture.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@picture.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    render :json => true
  end

  private

  def get_album
	@album = Album.find(params[:album_id])
  end
end
