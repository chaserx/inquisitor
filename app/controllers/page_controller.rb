class PageController < ApplicationController
  skip_before_action :require_login

  def welcome
  end

  def help
  end
end
