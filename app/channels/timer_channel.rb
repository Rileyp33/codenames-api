class TimerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "timer_#{params[:timer_id]}"
  end

  def receive(data)
    puts data
    return_data = data
    ActionCable.server.broadcast("timer_#{params[:timer_id]}", return_data)
  end
end