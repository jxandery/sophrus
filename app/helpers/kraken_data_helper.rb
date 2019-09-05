module KrakenDataHelper
  def find_symbol(data)
    data['result'].keys.first
  end

  def time_stamped(data)
    begin
      min = Time.now.min.to_s.rjust(2, '0')
      sec = Time.now.sec.to_s.rjust(2, '0')
      data[:min_sec] = "#{min}m-#{sec}s"
      data
    rescue => e
      SLACK.ping("Data for the time_stamped method can not be nil: #{e}", channel: '#system-notifs')
      Rails.logger.error("Data for the time_stamped method can not be nil: #{e.inspect}")
    end
  end

  def log_tick_data_error(data, time_key)
    data[:error].each do |e|
      SLACK.ping("Tick level error for #{time_key}: #{e}", channel: '#system-notifs')
      Rails.logger.error("There was a tick level error for #{time_key}: #{e.inspect}")
    end
  end
end
