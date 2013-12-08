# subscribe channels https://mtgox.com/api/2/stream/list_public?pretty
require 'pubnub'

class PriceTicker
  def initialize(options = {})
    @subscribe_key = options[:subscribe_key]

    options[:channels].each do |channel|
      pubnub.subscribe(
        channel: channel,
        callback: lambda { |msg| process(msg) }
      )
    end
  end

  def process(msg)
    write_to_db(msg)
    print_ticker(msg)
  end

  def write_to_db(msg)
    msg_headers = msg.instance_variable_get(:@headers)
    msg_body    = msg.instance_variable_get(:@message)

    ticker_params = {}

    %w(high low avg vwap last_local last_orig last buy sell).each do |key|
      ticker_params[key.to_sym] = msg_body['ticker'][key]['value_int']
    end

    begin
      date_time = DateTime.parse(msg_headers["DATE"])
      ticker_params.merge!(date: date_time)
    rescue Exception => e
      log.error "Error parsing date: #{e.message}"
    end

    TickerPrice.create!(ticker_params)
  end

  def print_ticker(msg)
    msg_headers = msg.instance_variable_get(:@headers)
    log.info "-" * 80
    log.info msg_headers["DATE"]

    msg_body = msg.instance_variable_get(:@message)

    %w(high low avg vwap last_local last_orig last buy sell).each do |key|
      log.info "#{key}: #{msg_body['ticker'][key]['display_short']}"
    end

    #log.info msg_body["ticker"] # full payload
    log.info "-" * 80
    $stdout.flush
  end

  def pubnub
    @pubnub ||= Pubnub.new(
      subscribe_key: @subscribe_key,
      publish_key:   'doesnt-matter-we-cant',
      origin:        'pubsub.pubnub.com',
      error_callback: lambda { |msg|
        log.info "CONNECTION INTERRUPTED: #{msg.inspect}"
      },
      connect_callback: lambda { |msg|
        log.info "CONNECTED: #{msg.inspect}"
      },
      logger: Logger.new('./log/pubnub.log', 'daily')
    )
  end

  def log
    @log ||= Logger.new(STDOUT)
  end
end

PriceTicker.new(
  subscribe_key: "sub-c-50d56e1e-2fd9-11e3-a041-02ee2ddab7fe",
  channels: ["d5f06780-30a8-4a48-a2f8-7ed181b4a13f"] #btc->usd
)

loop do
  sleep 1
end
