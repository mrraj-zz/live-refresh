class MiesController < ApplicationController
  include ActionController::Live
  
  def index
    response.headers['Content-Type'] = 'text/event-stream'
    100.times {
      response.stream.write "Hello World \n"
      sleep 1
    }
    response.stream.close
  end
end
