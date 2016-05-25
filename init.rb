require 'yaml'
require 'erb'

def load_config(file_path)
  # path = File.expand_path("../#{file_name}.yml", __FILE__)
  # puts path
  YAML.load(ERB.new(File.read(file_path)).result)
end

def pg_connection(settings)
  settings['port'] ||= '5432'

  "#{settings['adapter']}://#{settings['username']}:#{settings['password']}@#{settings['host']}:#{settings['port']}/#{settings['database']}"
end

TREY_DB_CONF = load_config('config/trey_db.yml')
TREY_FOLLOWERS_SCHEMA = load_config('config/trey_followers_count_schema.yml')
SRMA_CONF_YML = 'config/accountable.yml'

SRMA_RESOURCE_OUTPUT = 'output/resources.yml'
SRMA_BUNDLE_OUTPUT = 'output/bundles.yml'
FOLLOWERS_COUNT_OUTPUT = 'output/db_follower_counts.yml'
IDENTIFIER_MAPPING_OUTPUT = 'output/identifier_to_root_bundle_id.yml'
ACCOUNT_FOLLOWER_COUNT_OUTPUT = 'output/account_follower_count.yml'





