require 'reloader/sse'

class MonitorFilesystemsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type']  = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)
    begin
      directries = [
        File.join(Rails.root, 'app', 'assets'),
        File.join(Rails.root, 'app', 'views')
      ]
      notifier = INotify::Notifier.new
      notifier.watch(File.join(Rails.root, 'app'), :modify, :recursive) do |dir|
        sse.write({ dirs: dir.name }, event: "refresh")
      end
      notifier.run
      render nonthing: true
    rescue IOError => ioerror
      raise ioerror
    ensure
      sse.close
    end
  end
end
