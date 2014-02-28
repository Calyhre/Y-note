class Teachers::TestsController < Teachers::BaseController

  def index
    @courses = current_user.courses
  end
end
