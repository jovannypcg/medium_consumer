require 'httparty'

class Medium
    include HTTParty
    base_uri 'https://api.medium.com/v1'

    def initialize(opts = {})
        @options = {
            headers: {
                'Authorization' => 'Bearer 2635efb00a9312ca3ca0d15409acfd2e35288e3db0a8fd400e434aa5adceb703a'
            }
        }
    end

    def me
        self.class.get("/me", @options)
    end

end
