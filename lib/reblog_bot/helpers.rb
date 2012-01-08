
module ReblogBot
  module Helpers
    def client(config, account)
      Tumblife.configure {|c|
        c.consumer_key = config.consumer_key
        c.consumer_secret = config.consumer_secret
        c.oauth_token = account.oauth_token
        c.oauth_token_secret = account.oauth_token_secret
      }.client
    end
  end
end
