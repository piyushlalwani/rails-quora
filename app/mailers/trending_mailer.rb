class TrendingMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def post(posts, emails)
    @posts = posts
    mail(to: emails, subject: 'Hot picks from this week')
  end
end
