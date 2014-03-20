class Students::ReturnedExamsController < Students::BaseController
  before_filter :load_test
  before_filter :load_returned_exam
  before_filter :ensure_test_is_active, except: :show

  def show
    render :edit if @test.active?
  end

  def edit
  end

  def create
    update
  end

  def update
    @returned_exam.save

    answers = params[:answers] || []

    answers.each do |question_id, value|
      answer = @returned_exam.answers.where(question_id: question_id).first_or_initialize

      # Holy shit, ugly as hell :
      answer.answer = value[:answer].join ','

      answer.save
    end

    redirect_to [:students, :tests]
  end

  private

  def load_test
    @test = current_user.tests.find params[:test_id]
  end

  def load_returned_exam
    @returned_exam = current_user.returned_exam_for_test @test
  end

  def ensure_test_is_active
    not_found unless @test.active?
  end

end
