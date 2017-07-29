require 'httparty'

class Medium
    @@token = 'Bearer 2635efb00a9312ca3ca0d15409acfd2e35288e3db0a8fd400e434aa5adceb703a'

    include HTTParty
    base_uri 'https://api.medium.com/v1'

    def initialize(opts = {})
        @options = {
            headers: {
                'Authorization' => opts[:token] || @@token
            }
        }
    end

    def me
        self.class.get('/me', @options).body
    end

    def publications(username)
        self.class.get("/users/#{username}/publications", @options).body
    end
end
