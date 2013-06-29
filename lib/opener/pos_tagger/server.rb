require 'sinatra/base'
require 'httpclient'
require 'opener/webservice'

module Opener
  class POSTagger
    ##
    # POS Tagger server powered by Sinatra.
    #
    class Server < Webservice
      set :views, File.expand_path('../views', __FILE__)
      text_processor POSTagger
      accepted_params :input
    end # Server
  end # POSTagger
end # Opener
