require 'opener/webservice'

module Opener
  class POSTagger
    ##
    # POS Tagger server powered by Sinatra.
    #
    class Server < Webservice::Server
      set :views, File.expand_path('../views', __FILE__)

      self.text_processor  = POSTagger
      self.accepted_params = [:input]
    end # Server
  end # POSTagger
end # Opener
