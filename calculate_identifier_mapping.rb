require_relative 'init'

EXCEPT_RESOURCE_TYPES = %w[TabsView SignalTopic SignalCustomIndicator SignalStandardIndicator]

def res_identifier_to_account_id
  puts '----reading resources.yml begin'
  resources = YAML.load_file(SRMA_RESOURCE_OUTPUT)          # it will takes a long time to load resources.yml
  puts '----reading end'

  # puts resources.size

  resources = resources.select do |res|
    res['identifier'] != nil &&
      !EXCEPT_RESOURCE_TYPES.include?(res['resource_type'])
  end
  # puts resources.size

  result = {}
  resources.each do |res|
    type = res['resource_type']+res['stream_type'].to_s.capitalize
    result[type] ||= {}   # because there're duplicated identifier among different resource_types
    result[type][res['identifier']] = res['root_bundle_id']
  end
  result
end

mapping = res_identifier_to_account_id
puts 'resource types:', *mapping.keys
File.write(IDENTIFIER_MAPPING_OUTPUT, mapping.to_yaml)
