require 'rails_helper'

RSpec.describe AnswersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/1/questions/1/answers').to route_to('answers#index',
                                                              user_id: '1',
                                                              question_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/users/1/questions/1/answers/1').to route_to('answers#show',
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
