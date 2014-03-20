class CorrectorWorker
  include Sidekiq::Worker

  def perform(test_id)
    @test = Test.find test_id
    return unless @test.correctable?

    @test.update_attribute :correction_state, 'ongoing'

    @test.returned_exams.each do |returned_exam|
      if @test.random_grading_scheme?
        returned_exam.update_attribute :grade, rand
      else
        returned_exam.update_attribute :grade, grade_for_exam(returned_exam)
      end
    end

    unless @test.need_manual_correct?
      @test.update_attribute :correction_state, 'done'
    end
  end

  def grade_for_exam(returned_exam)
    grade = 0

    returned_exam.answers.each do |answer|
      next unless answer.question.can_autocorrect?

      question = answer.question

      if question.with_choices?
        correct_answers = question.choices.correct.map &:id
        user_answers    = answer.answer.to_s.split(',').map &:to_i
        wrong_answers   = (correct_answers | user_answers) - (correct_answers & user_answers)

        if wrong_answers.blank?
          # Correct
          grade += question.max_points
        else
          # Not correct
          if question.proportional?
            grade += question.max_points - ( wrong_answers.count * question.penalty )
          end
        end
      end
    end

    grade / returned_exam.answers.map(&:question).map(&:max_points).inject{|sum,x| sum + x }
  end
end
