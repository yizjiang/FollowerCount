require 'sequel'
require 'yaml'
require 'erb'

def load_config(file_name)
  path = File.expand_path("../#{file_name}.yml", __FILE__)
  # puts path
  YAML.load(ERB.new(File.read(path)).result)
end

def pg_connection_string(settings)
  settings['port'] ||= '5432'

  "#{settings['adapter']}://#{settings['username']}:#{settings['password']}@#{settings['host']}:#{settings['port']}/#{settings['database']}"
end


TREY_DB_CONF = load_config('trey_db')
TREY_FOLLOWERS_SCHEMA = load_config('trey_followers_count_schema')
DB = Sequel.connect(pg_connection_string(TREY_DB_CONF))



date = '2016-05-10'
total_counts = TREY_FOLLOWERS_SCHEMA.map do |table, follower_count_column|
  # p table, follower_count_column
  sum = DB[table.to_sym]
          .where(date: date)
          .sum(follower_count_column.to_sym)
          .to_i
  [table, sum]
end.to_h
puts total_counts.to_yaml



