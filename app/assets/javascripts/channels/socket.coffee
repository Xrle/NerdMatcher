App.socket = App.cable.subscriptions.create "SocketChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

    #Only do anything inside the iframe
    if (window.location.pathname == '/chat/show_messages')
      #Make only update on the correct chat page, as otherwise you get updated with messages from other people
      searchParams = new URLSearchParams(window.location.search);
      console.log(data)
      console.log(data['show_on'])
      console.log(data['body'])
      console.log(data['object'])
      console.log(searchParams.get('id'))
      if (parseInt(searchParams.get('id')) == parseInt(data['show_on']))
        $('#messages').append(data['body']);
        $(document).scrollTop($(document).height());
        if (data['message_id'] != 'nil')
          #Tell the server the message has been read
          @perform 'message_read', {message_id: data['message_id']}


