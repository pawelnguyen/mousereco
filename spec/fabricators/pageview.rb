Fabricator(:pageview, from: Mousereco::Pageview) do
end

Fabricator(:pageview_with_events, from: :pageview) do
  transient :start_at_timestamp
  timestamp { |attrs| attrs[:start_at_timestamp] || Time.now.to_i * 1000 }
  after_save do |pageview, attrs|
    2.times do |i|
      start_at_timestamp = attrs[:start_at_timestamp] || Time.now.to_i * 1000
      event_timestamp = start_at_timestamp + i * 2.minutes.to_i
      Fabricate(:event, timestamp: event_timestamp, pageview_id: pageview.id)
    end
  end
end

Fabricator(:pageview_with_visit, from: :pageview) do
  visit
end