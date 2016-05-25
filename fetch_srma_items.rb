require 'accountable'
require 'accountable/batch_api'
require 'accountable/api'
require_relative 'init'

PER_PAGE = 250
Accountable.load_from_yaml(SRMA_CONF_YML, 'development')

def fetch_srma(output, endpoint, request_options={})
  page = 0
  begin
    puts "----request srma #{endpoint} page: #{page}"
    results = Accountable::Api.get(endpoint,
                                   page: page,
                                   per_page: PER_PAGE,
                                   **request_options
    )
    items = results['collection']

    output << results['collection'].to_yaml.tap do |yaml_str|
      yaml_str.sub!(/^---$/, '') if page > 0 # remove heading '---' to concat
    end

    page += 1
  end while results['has_more'] && items.size > 0
end

def fetch_srma_to_file(output_path, endpoint, request_options={})
  File.open(output_path, 'w') do |output|
    fetch_srma(output, endpoint, request_options)
  end
end


fetch_srma_to_file(SRMA_BUNDLE_OUTPUT, 'bundles',
                   fields: 'id,name,root_bundle_id,account_id,time_zone,state')

fetch_srma_to_file(SRMA_RESOURCE_OUTPUT, 'resources',
                   fields: 'id,identifier,name,resource_type,stream_type,root_bundle_id')
