require 'sidekiq'

threads ENV['PUMA_MIN_THREADS'] || 2, ENV['PUMA_MAX_THREADS'] || 4
workers 1
port ENV['PORT']

on_worker_boot do
  @worker_pid ||= spawn("bundle exec sidekiq -c 2")

  t = Thread.new {
    Process.wait(@worker_pid)
    puts "Worker died. Bouncing unicorn."
    Process.kill 'QUIT', Process.pid
  }

  t.abort_on_exception = true
end
