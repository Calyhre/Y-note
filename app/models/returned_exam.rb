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
    if question.question_type == 'choices'
      answer = answers.find_by(question: question)
      answer.answer.split ',' unless answer.nil?
    else
      answers.find_by question: question
    end
  end

  def literal_grade
    case test.grading_scheme
    when 'classic', 'random'
      "#{grade.to_i} / 20"
    when 'percentage'
      "#{grade.to_i / 20 * 100}%"
    when 'letter'
      # TODO
      "TODO"
    when 'oeapdt'
      # TODO
      "TODO"
    end
  end
end
