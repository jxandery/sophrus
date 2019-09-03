module KrakenDataHelper
  def find_symbol(data)
    data['result'].keys.first
  end

  def time_stamped(data)
    min = Time.now.min.to_s.rjust(2, '0')
    sec = Time.now.sec.to_s.rjust(2, '0')
    data[:min_sec] = "#{min}-#{sec}"
    data
  end

  def log_tick_data_error(data, time_key)
    data[:error].each do |e|
      SLACK.ping("Tick level error for #{time_key}: #{e}", channel: '#system-notifs')
      Rails.logger.error("There was a tick level error for #{time_key}: #{e.inspect}")
    end
  end
end
