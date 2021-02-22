class ItemsController < ApplicationController
  def index
    url = 'https://jsonplaceholder.typicode.com/posts'
    uri = URI(url)
    raw_response = Net::HTTP.get(uri)

    response = JSON.parse(raw_response)
    status = :ok
  rescue => error
    response = { errors: [{ detail: error.message }] }
    status = :not_found
  ensure
    render json: response, status: status
  end
end
