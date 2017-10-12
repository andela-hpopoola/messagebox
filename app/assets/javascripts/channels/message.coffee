App.message = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#all-messages').prepend data.message

  send_message: (message) ->
    @perform 'send_message', message: message

jQuery(document).on 'turbolinks:load', ->
  $('#submit-message-btn').click (e) ->
    message_content = $('#message-content').val()
    $('#message-content').val('')
    if $.trim(message_content).length > 0
      App.message.send_message message_content
    e.preventDefault()