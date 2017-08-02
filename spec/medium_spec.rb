require 'medium'

describe Medium do
  let(:client) { Medium.new }
  let(:user_info) { "{\"data\":{\"id\":\"1037195f365b6fc4b526a905a02278532eb369343cc68238c18ea932ce71e8a25\",\"username\":\"darthcharles\",\"name\":\"Carlos Contreras\",\"url\":\"https://medium.com/@darthcharles\",\"imageUrl\":\"https://cdn-images-1.medium.com/fit/c/400/400/1*RhfEttHfesPrkYnvBb26MA.jpeg\"}}" }
  let(:publications) { "{\"data\":[{\"id\":\"26b3c59f948\",\"name\":\"Creatomic\",\"description\":\"Creatomic is a marketing and creative services agency founded and built by Jon Westenberg\",\"url\":\"https://medium.com/hi-my-name-is-jon\",\"imageUrl\":\"https://cdn-images-1.medium.com/fit/c/400/400/1*fSV0EP-pYIAorrCRf8wrxg.png\"},{\"id\":\"3a2bc986994b\",\"name\":\"Tiny Tech Tales\",\"description\":\"A series of tiny snippets and rants from the programming world\",\"url\":\"https://medium.com/tiny-tech-tales\",\"imageUrl\":\"https://cdn-images-1.medium.com/fit/c/400/400/1*DiFwpX7Y2WTpXSTW2Mv2IA.png\"}]}" }
  let(:titles) { [ "Creatomic", "Tiny Tech Tales"] }

  it 'responds to all methods' do
    expect(client).to respond_to(:me)
    expect(client).to respond_to(:publications)
    expect(client).to respond_to(:titles)
    expect(client).to respond_to(:contributors)
  end

  it 'gets user information' do
    stub_request(:get, 'https://api.medium.com/v1/me').to_return(:body => user_info, :status => 200)

    response = client.me

    parsed_expected_user_info = JSON.parse(user_info)["data"]
    expect(response).to eq(parsed_expected_user_info)
  end

  context 'publications' do
    before(:each) do
      stub_request(:get, 'https://api.medium.com/v1/users/any_user/publications')
        .with(headers: {'Authorization'=>'Bearer 2635efb00a9312ca3ca0d15409acfd2e35288e3db0a8fd400e434aa5adceb703a'})
        .to_return(:body => publications, :status => 200)
    end

    it 'gets user publications' do
      pubs = client.publications('any_user')

      parsed_expected_publications = JSON.parse(publications)["data"]
      expect(pubs).to eq(parsed_expected_publications)
    end

    it 'retrieves title of publications' do
      pubs = client.publications('any_user')
      ttls = client.titles(pubs)

      expect(ttls.size).to eq(titles.size)
      expect(ttls).to eq(titles)
    end
  end
end
