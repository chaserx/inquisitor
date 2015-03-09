require 'rails_helper'

RSpec.describe QuestionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/1/questions').to route_to('questions#index', user_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/users/1/questions/new').to route_to('questions#new', user_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/users/1/questions/1').to route_to('questions#show', user_id: '1',
                                                                        id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/users/1/questions/1/edit').to route_to('questions#edit',
                                                           user_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/1/questions').to route_to('questions#create', user_id: '1')
    end

    it 'routes to #update' do
      expect(put: '/users/1/questions/1').to route_to('questions#update', user_id: '1',
                                                                          id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/1/questions/1').to route_to('questions#destroy',
                                                         user_id: '1',
                                                         id: '1')
    end
  end
end
