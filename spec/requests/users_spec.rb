require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/:id" do
    let(:user){ User.create name: 'Ada', email: 'ada@wong.com', password: 'madadder' }
    let(:auth_header) do
      token = Knock::AuthToken.new(payload: {sub: user.id}).token
      {
        'Authorization': "Bearer #{token}"
      }
    end

    it "creates a user" do
      payload = {
        user: {
          username: 'Chris',
          email: 'chris@redfield.com',
          password: 's.t.a.r.s.',
          password_confirmation: 's.t.a.r.s.'
        }
      }

      post users_path, params: payload
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)
      expect(json["user"]["username"]).to eq "Chris"
      expect(json["jwt"]).to_not be_blank
    end

    it "should return errors when creation fails" do
      payload = {
        user: {
          username: 'Leon',
          email: 'leon@kennedy.com',
          password: 'adaadaada',
          password_confirmation: 'adaadaad'
        }
      }

      post users_path, params: payload
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json["errors"]["password_confirmation"]).to_not be_blank
    end
  end
end
