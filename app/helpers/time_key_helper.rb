module TimeKeyHelper
  def self.call
    "#{year}-#{month}-#{day}-#{hour}"
  end

  def self.double_digit_format(num)
    num.to_s.last(2).rjust(2, '0')
  end

  def self.year
    double_digit_format(Time.now.year)
  end

  def self.month
    double_digit_format(Time.now.month)
  end

  def self.day
    double_digit_format(Time.now.day)
  end

  def self.hour
    double_digit_format(Time.now.hour)
  end

  def self.min
    double_digit_format(Time.now.min)
  end

  def self.sec
    double_digit_format(Time.now.sec)
  end
end
