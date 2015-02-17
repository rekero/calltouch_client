%w{rest_client json}.each { |lib| require lib }


class CalltouchClient

  class ApiError < StandardError
  end	


  def initialize(client_api_id)
    @client_api_id = client_api_id
    @session_id = nil
    @api_url = 'http://api.calltouch.ru/calls-service/RestAPI'
    @options = { clientApiId: client_api_id }
  end



  # Request
  def set_request options = {}  	
    get 'requests/orders/register', options.merge!(@options)
  end	

  # Order by calling
  def set_order options = {}
    get 'orders/register', options.merge!(@options)
  end	

  # Search
  def search options = {}
    get 'requests', options.merge!(@options)
  end	

  # Get request
  def get_request id, options = {}
    get "requests/#{id}", options.merge!(@options)
  end	

  # Get order
  def get_order id, options = {}
    get "requests/orders/#{id}", options.merge!(@options)
  end
  
  # Approve order
  def approved id, options = {}
    get "requests/orders/#{id}/approve", options.merge!(@options)
  end

  # Cancel order
  def canceled id, options = {}
    get "requests/orders/#{id}/cancel", options.merge!(@options)
  end  

  # Reject order
  def rejected id, options = {}
    get "requests/orders/#{id}/reject", options.merge!(@options)	
  end    

  # Complete order
  def completed id, options = {}
    get "requests/orders/#{id}/complete", options.merge!(@options)
  end   




  #  Calls by sources

  # clientApiId - required
  # dateFrom - required
  # dateTo - required
  # clientId
  # source.value
  # source.filterMode
  # medium.value
  # medium.filterMode
  # utmSource.value
  # utmSource.filterMode
  # utmMedium.value
  # utmMedium.filterMode
  # utmTerm.value
  # utmTerm.filterMode
  # utmContent.value
  # utmContent.filterMode
  # utmCampaign.value
  # utmCampaign.filterMode
  # keyword.value
  # keyword.filterMode
  # ani.value
  # ani.filterMode
  # phoneNumber.value
  # phoneNumber.filterMode
  # uniqueOnly
  # callId
  # withMapVisits
  def calls site_id, options = {}
  	get "#{site_id}/calls-diary/calls", options.merge!(@options)
  end	


  # Total calls count
  # access_token - required
  # dateFrom 
  # dateTo
  def calls_count site_id, options = {}
  	get "statistics/#{site_id}/calls/total-count", options.merge!({ access_token: @client_api_id })
  end	


  # Total calls count by date
  # access_token - required
  # dateFrom 
  # dateTo  
  def calls_by_date site_id, options = {}
  	get "statistics/#{site_id}/calls/count-by-date", options.merge!({ access_token: @client_api_id })
  end	




  # Pass post, get, delete, put and patch to the request method
  def method_missing(method_name, *arguments, &block)
    if method_name.to_s =~ /(post|get|put|patch|delete)/
      request($1.to_sym, *arguments, &block)
    else
      super
    end
  end


  private


  # Generic request method
  def request(strategy, uri, data)
    if strategy == :get
      response = RestClient.get "#{@api_url}/#{uri}/", params: data, accept: 'application/json'
    else
      response = RestClient.send strategy, "#{@api_url}/#{uri}/", data, accept: 'application/json'
    end
    response = JSON.parse response
    #require_success! response
    response
  end	

  #def require_success!(response)
    #raise ApiError, response['message'] unless response['success'] 
    #response
  #end




end	