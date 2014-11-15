table_names0 = %w( prefectures )
table_names0.each do |table_name|
  path = Rails.root.join('db', 'seeds', "#{table_name}.rb")
  next unless File.exist?(path)
  puts "Creating #{table_name}...."
  require(path)
end

table_names1 = %w( events schedule_items )
table_names1.each do |table_name|
  path = Rails.root.join('db', 'seeds', Rails.env, "#{table_name}.rb")
  next unless File.exist?(path)
  puts "Creating #{table_name}...."
  require(path)
end
