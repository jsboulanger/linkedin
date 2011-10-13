require 'oauth'
require 'active_support'

if !Hash.respond_to?(:with_indifferent_access) # Active Support 2.x and 3.x
  require 'active_support/core_ext/object/to_query'
  require 'active_support/core_ext/hash/slice'
end

module LinkedIn

  class << self
    attr_accessor :token, :secret, :default_profile_fields

    # config/initializers/linkedin.rb (for instance)
    #
    # LinkedIn.configure do |config|
    #   config.token = 'consumer_token'
    #   config.secret = 'consumer_secret'
    #   config.default_profile_fields = ['education', 'positions']
    # end
    #
    # elsewhere
    #
    # client = LinkedIn::Client.new
    def configure
      yield self
      true
    end
  end

  autoload :Api,     "linked_in/api"
  autoload :Client,  "linked_in/client"
  autoload :Mash,    "linked_in/mash"
  autoload :Errors,  "linked_in/errors"
  autoload :Helpers, "linked_in/helpers"
  autoload :Search,  "linked_in/search"
  autoload :Version, "linked_in/version"
end
