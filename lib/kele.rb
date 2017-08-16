require 'httparty'
require 'json'
require 'kele'
require 'roadmap'

class Kele
  include HTTParty
  include Roadmap
    base_uri "https://www.bloc.io/api/v1"

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {"email": email, "password": password})
    #raise InvalidError.new() if response.code != 200
    @auth_token = response["auth_token"]
  end

  def get_me
    url = "https://www.bloc.io/api/v1/users/me"
    response = self.class.get(url, headers: {"authorization" => @auth_token})
    body = JSON.parse(response.body)
  end

  def get_mentor_availabiltiy(id)
    mentor_url = "https://www.bloc.io/api/v1/mentors/#{id}/student_availability"
    response = self.class.get(mentor_url, headers: {"content_type" => "application/json", "authorization" => @auth_token})
    body = JSON.parse(response.body)
  end

  def get_messages(page)
    response = self.class.get("https://www.bloc.io/api/v1/message_threads", body: {"page" => page}, headers: {"authorization" => @auth_token})
    body = JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, stripped-text)
    response = self.class.post("https://www.bloc.io/api/v1/messages", body: {"sender" => sender, "recipient_id" => recipient_id, "token" => token, "subject" => subject, "stripped-text" => stripped-text})
    body = JSON.parse(response.body)
  end
end
