prefectures = Prefecture.all
title_strings1 = %w(落語 演劇 民謡 ジャズ)
title_strings2 = %w(フェスタ まつり の集い)
venue_strings = %w(文化会館 民ホール 総合体育センター)

100.times do |n|
  pref = prefectures.sample
  title = title_strings1.sample + title_strings2.sample
  venue = pref.name + venue_strings.sample
  Event.create!(prefecture: pref, title: title, venue: venue)
end
