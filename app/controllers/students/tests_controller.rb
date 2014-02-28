class Students::TestsController < Students::BaseController

  def index
    @tests = current_user.tests.started.decorate
  end

  def show
    @test = current_user.tests.started.find_by(id: params[:id]).decorate
  end
end
