$ ->
  $('.alert-dismissable').delay(2000).slideToggle(500)

  client = new Faye.Client('http://localhost:8000/faye', timeout: 120)

  buy = $('.live-ticker li.buy span')
  sell = $('.live-ticker li.sell span')
  client.subscribe '/ticker', (message) ->
    console.log message
    buy.text(message.buy)
    sell.text(message.sell)

