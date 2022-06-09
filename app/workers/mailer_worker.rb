class MailerWorker
  include Sidekiq::Worker

  def perform(*args)
    posts = Post.includes(:answers).order('answers.votes desc').limit(10)
    emails = User.pluck(:email).join(", ")

    TrendingMailer.post(posts, emails).deliver
  end
end
