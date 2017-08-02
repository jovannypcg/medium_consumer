require 'httparty'
require 'pry'

class Medium
  @@token = 'Bearer 2635efb00a9312ca3ca0d15409acfd2e35288e3db0a8fd400e434aa5adceb703a'

  include HTTParty

  def initialize(host: 'https://api.medium.com/v1')
    @options = {
      headers: {
        'Authorization' => @@token
      },
      base_uri: host
    }
  end

  def me
    JSON.parse(self.class.get('/me', @options).body)["data"]
  end

  def publications(username)
    JSON.parse(self.class.get("/users/#{username}/publications", @options).body)["data"]
  end

  def contributors(publication_id)
    self.class.get("/publications/#{publication_id}/contributors", @options).body
  end

  def titles(publications)
    publications.map { |pub| pub["name"]  }
  end
end
