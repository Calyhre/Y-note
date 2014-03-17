class Teachers::TestsController < Teachers::BaseController

  before_filter :load_course, except: :index

  def index
    @courses = current_user.courses
  end

  def new
    @test = Test.new course: @course
  end

  def create
    @test = Test.new strong_params

    if @test.save
      @course.tests << @test
      redirect_to @test
    else
      render action: :new
    end
  end

  private

  def load_course
    @course = current_user.courses.find_by id: params[:course_id]
    return not_found unless @course
  end

  def strong_params
    params.require(:test).permit(
      :title,
      :instruction,
      :penalty_type,
      :penalty,
      :anonymous,
      :grading_scheme,
      :coefficient,
      :start_at,
      :end_at,
      questions_attributes: [
        :id,
        :title,
        :instruction,
        :correction,
        :question_type,
        :position,
        :max_points,
        :penalty_type,
        :penalty,
        :_destroy,
        choices_attributes: [
          :title,
          :correct,
          :position,
          :_destroy
        ]
      ]
    )
  end

end
