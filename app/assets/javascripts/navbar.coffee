$ ->
  $('.alert-dismissable').delay(2000).slideToggle(500)

  client = new Faye.Client('http://localhost:8000/faye', timeout: 120)
  window.client = client

  subscription = client.subscribe '/ticker', (message) ->
    console.log "message!"
    console.log message

  subscription.then (msg) -> console.log "#{msg} promise"

  setTimeout( =>
    promise = client.publish('/ticker', {text: 'hi'} )
    promise.then( (-> console.log "msg rcvd"), (err) -> console.log("problem", err) )
  , 500)
