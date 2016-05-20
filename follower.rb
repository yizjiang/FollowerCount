require_relative 'init'


OPTIMUS_VERSION = 'api/v1/'

###############################
###### get all resources  #####
###############################


resource_url = File.join(config[:base_url], "#{OPTIMUS_VERSION}", "resources/",config[:bundle_id].to_s)

options = {
  headers: default_headers,
  method: 'get'
}
#
# response = make_request(resource_url, options)
#
# p response.response_body

###############################
######    get a metric    #####
###############################

metric = {
  "metrics"    =>  ['page_fans'],
  "page_ids"   =>  ['303233436375483'],
  "user_id"    =>   config[:user_id],
  "bundle_id"  =>   config[:bundle_id].to_s,
  "since"      => '20150403',
  "until"      => '20150503',
  "network"    => 'facebook',
}

metric_url = File.join(config[:base_url], "#{OPTIMUS_VERSION}", "metrics")

options = {
  method: 'post',
  headers: default_headers,
  body: metric.to_json,
  params: metric
}

response = make_request(metric_url, options)

p '==================='
p response.response_body