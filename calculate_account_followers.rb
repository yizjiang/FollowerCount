require_relative 'init'


TABLE_TO_RESOURCE_TYPE = TREY_FOLLOWERS_SCHEMA.map do |table, table_conf|
  [table, table_conf['resource_type']]
end.to_h
IDENTIFIER_TO_ACCOUNT_ID = YAML.load_file(IDENTIFIER_MAPPING_OUTPUT)
FOLLOWER_COUNTS = YAML.load_file(FOLLOWERS_COUNT_OUTPUT)

srma_missing_identifiers = []
account_counts = {}

FOLLOWER_COUNTS.each do |table, counts|
  resource_type = TABLE_TO_RESOURCE_TYPE[table]

  counts.each do |count|
    identifier = count['identifier']
    account_id = IDENTIFIER_TO_ACCOUNT_ID[resource_type][count['identifier']]

    if account_id
      account_counts[account_id] ||= {}
      account_counts[account_id][resource_type] ||= 0
      account_counts[account_id][resource_type] += count['followers']
    else
      # puts "#{identifier} cannot be found"
      srma_missing_identifiers << identifier
    end
  end
end

account_counts.each do |account_id, account_count|
  account_count['total_count'] = account_count.values.reduce(0, :+)
end

File.write(ACCOUNT_FOLLOWER_COUNT_OUTPUT, account_counts.to_yaml)
File.write('output/srma_missing_identifiers.yml', srma_missing_identifiers.to_yaml)

