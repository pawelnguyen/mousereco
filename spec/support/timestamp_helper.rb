module TimeHelper
  def miliseconds_timestamp_ago(time_ago = 0)
    miliseconds_timestamp(Time.now - time_ago)
  end

  def miliseconds_timestamp(time)
    time.to_i * 1000
  end
end