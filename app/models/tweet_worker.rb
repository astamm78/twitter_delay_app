class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user

    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here

    # Must export CLIENT API tokens on command line - On Heroku these will be included with environment files
    # This creates a new Twitter client to tweet from with user's authorized tokens
    client = Twitter::Client.new( :oauth_token => user.oauth_token, :oauth_token_secret => user.oauth_secret )
    # This makes the API call and posts the tweet on the background job server
    client.update(tweet.content)
  end

end
