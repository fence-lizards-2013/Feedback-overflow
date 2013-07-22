class OauthController < ApplicationController
  def login
    redirect_to oauth_client.auth_code.authorize_url(
      :redirect_uri => "http://localhost:3000/callback"
    )
  end

  def callback
    access_token = get_access_token(params[:code])
    response = JSON.parse(access_token.get('https://auth-devbootcamp-com-staging.herokuapp.com/me').body)
    cohort = Cohort.find_by_cohort_id(response['cohort_id'])
    user = User.find_or_create_by_email(response['email'])
    params = {
              name: response['name'],
              password: SecureRandom.urlsafe_base64,  #OVER RIDES PASSWORD EVERYTIME SOLUTION FOR THIS NEEDED
              cohort_id: cohort.id,
              socrates_auth: true
    }

    user.update_attributes(params)
    if user.save
      sign_in user
      redirect_to root_url
    else
      flash[:error] = "Not authenticated, something went wrong. Please try again."
      redirect_to root_url
    end
  end

  private

  def oauth_client
    raise RuntimeError, "You must set SOC_CLIENT_ID and SOC_CLIENT_SECRET in your server environment." unless ENV['SOC_CLIENT_ID'] and ENV['SOC_CLIENT_SECRET']

    @client ||= OAuth2::Client.new(
      ENV['SOC_CLIENT_ID'],
      ENV['SOC_CLIENT_SECRET'],
      :site => 'https://devbootcamp.com',
      :token_url => 'https://auth-devbootcamp-com-staging.herokuapp.com/oauth/token',
      :authorize_url => 'https://auth-devbootcamp-com-staging.herokuapp.com/oauth/authorize?'
      )
  end

  def get_access_token(code)
    oauth_client.auth_code.get_token(code, {
      :redirect_uri => 'http://localhost:3000/callback'
    })
  end

  # def redirect_uri
  #   host_and_port = request.host
  #   host_and_port << ":3000" if request.host == "localhost"
  #   "http://#{host_and_port}/callback"
  # end
end
