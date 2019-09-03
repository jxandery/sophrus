module TimekeyHelper
  def time_key
    "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}-#{Time.now.hour}"
  end
end
