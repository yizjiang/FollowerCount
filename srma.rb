require_relative 'init'
require 'accountable'
require 'accountable/batch_api'

Accountable.load_from_yaml("./accountable.yml", 'development')

# page = 0
# resp = Accountable::Api.get('resources',
#                             page: page,
#                             per_page: 10,
# )

p '----request srma'
# api = Accountable::BatchApi.new
# api.batch_collection('resources', fields: 'id,identifier,name,resource_type,stream_type')
# results = api.results

page = 100
results = Accountable::Api.get('resources',
                               # page: page,
                               # per_page: 10,
                               # fields: 'id,identifier,name,resource_type,stream_type'
)

File.write('output/resources.yaml', results.to_yaml)


# resource = Accountable::Api.get('resources/1110163')
# resource = Accountable::Api.get('resources/180151')
# resource = Accountable::Api.get('resources/199689')
# puts resource.to_yaml