class User < ActiveRecord::Base

  has_many :tweets

  def post_tweet(content)
    twitter_client.update(content)
  end

  def tweet(status)
    tweet = tweets.create!(:content => status)
    TweetWorker.delay_until(3.seconds.from_now).perform_async(tweet.id)
  end

  private

  def twitter_client
    Twitter::Client.new( :oauth_token => self.oauth_token, :oauth_token_secret => self.oauth_secret )
  end


end
