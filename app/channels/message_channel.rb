class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    message = Message.create! content: data['message']
    ActionCable.server.broadcast "message_channel", message: render_message(message)
  end

  private
    def render_message(message)
      MessagesController.render partial: 'messages/message', locals: { message: message }      
    end
end
