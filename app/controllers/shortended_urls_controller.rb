class ShortendedUrlsController < ApplicationController
	def show
		link = ShortendedUrl.find_by_slug(params[:slug]) 
    raise(StandardError, 'Invalid url') if link.nil?
    redirect_to link.url, allow_other_host: true
	end
end
