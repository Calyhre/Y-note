class ReturnedExam < ActiveRecord::Base
  include ActAsTimeAsBoolean

  belongs_to :test
  belongs_to :user

  has_many :answers
  has_many :contestations

  has_many :comments, as: :parent

  time_as_boolean :deleted, opposite: :active

  accepts_nested_attributes_for :answers

  def answer_for_question(question)
    answer = nil
    if question.question_type == 'choices'
      answer = answers.find_by(question: question)
      answer = answer.answer.split ',' unless answer.nil?
    else
      answer = answers.find_by question: question
    end

    answer ||= []
  end

  def released?
    self.persisted?
  end

  def literal_grade
    case test.grading_scheme
    when 'classic', 'random'
      "#{(grade.to_f * 2 * 20).round / 2.0} / 20"
    when 'percentage'
      "#{grade.to_f * 100}%"
    when 'letter'
      # TODO
      "TODO"
    when 'oeapdt'
      # TODO
      "TODO"
    end
  end
end
