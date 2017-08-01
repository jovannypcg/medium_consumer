require 'httparty'
require 'pry'

class Medium
    @@token = 'Bearer 2635efb00a9312ca3ca0d15409acfd2e35288e3db0a8fd400e434aa5adceb703a'

    extend HTTParty

    def self.options
        {
            headers: {
                'Authorization' => @@token
            }
        }
    end

    def self.me
        HTTParty.get('https://api.medium.com/v1/me', options).body
    end

    def self.publications(username)
        binding.pry
        JSON.parse(HTTParty.get("https://api.medium.com/v1/users/#{username}/publications", options).body)["data"]
    end

    def self.contributors(publication_id)
        HTTParty.class.get("https://api.medium.com/v1/publications/#{publication_id}/contributors", options).body
    end

    def self.desc_user(userid)
        HTTParty.get("https://api.medium.com/v1/users/#{userid}", options).body
    end

    def self.titles(publications)
        publications.each { |pub| puts pub["name"]  }
    end
end
