require 'sequel'
require 'erb'
require_relative 'init'

TARGET_DATE = (Time.now - 10*24*3600).to_date.to_s
DB = Sequel.connect(pg_connection(TREY_DB_CONF))


total_counts = TREY_FOLLOWERS_SCHEMA.map do |table, table_conf|
  # p table, follower_count_column
  identifier_column = table_conf['identifier_column']
  count_column = table_conf['count_column']

  sql = %Q[
    SELECT #{identifier_column}, SUM(#{count_column})
    FROM #{table}
    WHERE date='#{TARGET_DATE}'
    GROUP BY #{identifier_column}
  ]
  # puts sql

  results = DB.fetch(sql).all
  sums = results.map do |res|
    {
      'identifier' => res[identifier_column.to_sym],
      'followers' => res[:sum].to_i
    }
  end

  [table, sums]
end.to_h

File.write(FOLLOWERS_COUNT_OUTPUT, total_counts.to_yaml)
# puts total_counts.to_yaml



