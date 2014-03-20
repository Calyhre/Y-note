namespace :ynote do
  namespace :correct do
    desc "Correct all the tests !"
    task all: :environment do
      Test.to_correct.each do |test|
        CorrectorWorker.perform_async test.id
      end
    end
  end
end
