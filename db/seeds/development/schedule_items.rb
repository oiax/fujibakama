t = Time.zone.local(2015, 1, 1)

Event.all.each_with_index do |event, index|
  s = rand(10) + 10
  e = s + 2
  ScheduleItem.create!(event: event,
    starts_at: t.advance(hours: s), ends_at: t.advance(hours: e))

  if index % 5 == 0
    t = t.advance(days: 1)
    ScheduleItem.create!(event: event,
      starts_at: t.advance(hours: s), ends_at: t.advance(hours: e))
  end

  t = t.advance(days: rand(3) + 1)
end
