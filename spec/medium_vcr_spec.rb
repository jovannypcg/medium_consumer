require 'medium'

describe Medium do
  let(:client) { Medium.new }
  let(:user_info) do
    {
      "id" => "1037195f365b6fc4b526a905a02278532eb369343cc68238c18ea932ce71e8a25",
      "username"=>"jovannypcg",
      "name"=>"Jovanny Cruz",
      "url"=>"https://medium.com/@jovannypcg",
      "imageUrl"=>"https://cdn-images-1.medium.com/fit/c/400/400/1*RhfEttHfesPrkYnvBb26MA.jpeg"
    }
  end

  context '#me' do
    it 'gets user information' do
      VCR.use_cassette 'user' do
        response = client.me

        expect(response).to eq(user_info)
      end
    end

    it 'contains the expected keys' do
      VCR.use_cassette 'user' do
        response = client.me

        expected_keys = user_info.keys

        expect(response.keys).to eq(expected_keys)
      end
    end
  end

  context '#publications' do
    it 'gets user publications' do
      VCR.use_cassette 'publications' do
        pubs = client.publications(user_info["id"])

        expect(pubs).not_to be_empty
      end
    end

    let(:expected_titles) { [ "Creatomic", "Tiny Tech Tales"] }

    it 'retrieves title of publications' do
      VCR.use_cassette 'publications' do
        pubs = client.publications(user_info["id"])
        titles = client.titles(pubs)

        expect(titles).to include(*expected_titles)
      end
    end
  end
end
