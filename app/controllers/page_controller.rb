class PageController < ApplicationController
  skip_before_action :require_login
  layout 'landing'

  def welcome
  end

  def help
  end
end
