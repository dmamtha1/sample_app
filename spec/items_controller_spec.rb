require "rails_helper"

RSpec.describe ItemsController, :type => :controller do
  describe 'GET index' do
    it 'returns 200 status code and list of items when http client returns successful response' do
      data = [
        {
          userId: 1,
          id: 1,
          title: 'title',
          body: 'body'
        }
      ]

      stub_request(
        :get,
        URI.escape('https://jsonplaceholder.typicode.com/posts'),
      ).to_return(status: 200, body: data.to_json)

      get :index

      expect(response.status).to eq(200)
      expect(response.body).to eq(data.to_json)
    end

    it 'returns 200 when http client returns successful response' do
      stub_request(
        :get,
        URI.escape('https://jsonplaceholder.typicode.com/posts'),
      ).to_raise(StandardError.new("some error"))

      get :index

      expect(response.status).to eq(404)
      expect(response.body).to eq({ errors:[{ detail: 'some error' }] }.to_json)
    end
  end
end
