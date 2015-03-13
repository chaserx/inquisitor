require 'rails_helper'

RSpec.describe AnswersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/1/questions/1/answers').to route_to('answers#index',
                                                              user_id: '1',
                                                              question_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/users/1/questions/1/answers/new').to route_to('answers#new',
                                                                  user_id: '1',
                                                                  question_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/users/1/questions/1/answers/1').to route_to('answers#show',
                                                                id: '1', user_id: '1',
                                                                question_id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/users/1/questions/1/answers/1/edit').to route_to('answers#edit',
                                                                     id: '1',
                                                                     user_id: '1',
                                                                     question_id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users/1/questions/1/answers').to route_to('answers#create',
                                                               user_id: '1',
                                                               question_id: '1')
    end

    it 'routes to #update' do
      expect(put: '/users/1/questions/1/answers/1').to route_to('answers#update',
                                                                id: '1', user_id: '1',
                                                                question_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/1/questions/1/answers/1').to route_to('answers#destroy',
                                                                   id: '1', user_id: '1',
                                                                   question_id: '1')
    end
  end
end
