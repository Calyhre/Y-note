class TestNotificationMailer < ActionMailer::Base
  layout 'mailer'
  default from: 'no-reply@example.com'

  def new_test(test_id)
    @test = Test.find test_id
    mail to: 'no-reply@example.com', bcc: @test.mailing_list, subject: "Nouveau devoir de #{@test.course.subject.title}"
  end

  def update_test(test_id)
    @test = Test.find test_id
    mail to: 'no-reply@example.com', bcc: @test.mailing_list, subject: "Changement pour le devoir de #{@test.course.subject.title}"
  end
end
