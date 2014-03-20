class Teachers::TestsController < Teachers::BaseController

  before_filter :load_course, except: :index
  before_filter :load_test, except: :index

  def index
    @courses = current_user.courses
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @test.update_attributes strong_params
      @course.tests << @test
      redirect_to [:teachers, @course, @test]
    else
      render action: :edit
    end
  end

  def update
    return not_found unless @test.editable?

    if @test.update_attributes strong_params
      redirect_to [:teachers, @course, @test]
    else
      render action: :edit
    end
  end

  private

  def load_course
    @course = current_user.courses.find_by id: params[:course_id]
    return not_found unless @course
  end

  def load_test
    if params[:id]
      @test = current_user.courses_tests.find params[:id]
    else
      @test = Test.new course: @course
    end
    return not_found unless @test
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
          :id,
          :title,
          :correct,
          :position,
          :_destroy
        ]
      ]
    )
  end

end
