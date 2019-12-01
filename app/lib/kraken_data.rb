class KrakenData
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def find_symbol
    puts "data: #{data}"
    data['result'].keys.first.to_s
  end

  def time_stamped
    min = TimeKeyHelper.min
    sec = TimeKeyHelper.sec
    data[:min_sec] = "#{min}m-#{sec}s"
    data
  end

  def log_tick_data_error(time_key)
    data[:error].each do |error|
      ::SLACK.ping("Tick level error for #{time_key}. Error: #{error}")
    end
  end

  def validate_data
    ::SLACK.ping("Kraken provided invalid data.") if !valid_kraken_format?
    valid_kraken_format?
  end

  def valid_kraken_format?
    expected_keys = [:result, :error]
    data.is_a?(Hash) && (expected_keys - data.keys).empty?
  end
end
