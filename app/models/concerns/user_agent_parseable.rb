module UserAgentParseable
  extend ActiveSupport::Concern

  included do
    before_save :truncate_user_agent
  end

  def browser
    USER_AGENT_PARSER.parse(user_agent).to_s
  end

  def device
    USER_AGENT_PARSER.parse(user_agent).device.family
  end

  def os
    USER_AGENT_PARSER.parse(user_agent).os.to_s
  end

  private
    def truncate_user_agent
      self.user_agent = user_agent.to_s.truncate(255)
    end
end
