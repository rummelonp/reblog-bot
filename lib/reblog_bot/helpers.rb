
module ReblogBot
  module Helpers
    def consumer(config)
      OAuth::Consumer.new(
        config.consumer_key,
        config.consumer_secret,
        site: 'http://api.tumblr.com',
      )
    end

    def access_token(config, account)
      OAuth::AccessToken.new(
        consumer(config),
        account.oauth_token,
        account.oauth_secret,
      )
    end

    def client(config, account)
      Tumblife.new access_token(config, account)
    end
  end
end
