class HomeController < ApplicationController
  def index
    @q = User.includes(:skills).ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end
