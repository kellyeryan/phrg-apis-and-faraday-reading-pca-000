class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get "https://api.foursquare.com/v2/venues/search" do |req|
      req.params['client_id'] = 'GY3RRCICTS1L4ESMK1PH3V5JPDOUKAGX0MIJBNOMC1INPDH1'
      req.params['client_secret'] = 'JAPDRP5NPCO43FURKVZ41KFNXRBBXDXNTHLAJ2HSOKV2K03F'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]{"errorDetail"}
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

      render "search"
    end
  end
end
