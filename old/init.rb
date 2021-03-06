require 'yaml'
require 'typhoeus'
require 'active_support/all'


class RequestError < RuntimeError; end

# Method for reading all the parameters in the conf.yml

def config
  @config ||= YAML.load_file('conf.yml').with_indifferent_access
end

# Helper method for adding authentication token

def default_headers
  {
    :Authorization => "Bearer "+config[:token], #"81cc66adbb90533f84f11c265597f86ecd8179c026382746bfa3119e11db7408",#
    'X-Vitrue-User-Id' => config[:user_id],
    'Content-Type' => 'application/json'
  }
end

# Helper method for making http request

def make_request(url, options)
  p '----making request----'
  p url
  p options

  resp = Typhoeus::Request.new(url, options)
  response = resp.run

  unless response.response_code == 200
    p response.response_code
    p response.response_body
    #p response
    raise RequestError
  end
  response
end


# Method for fetching all the items when one API call doesn't return all results
# Will trigger multiple API calls and concat the results in items.

# def fetch_all(url, options)
#   offset = original_offset = options[:offset] || 0
#   limit = options[:limit] || PER_REQUEST_LIMIT
#   count = 0
#   items = []
#
#   begin
#     options[:params] = (options[:params] || {}).merge(offset: offset, limit: limit)
#     resp = make_request(url, options)
#     body_hash = JSON.parse(resp.body)
#
#     items.concat body_hash['items']
#     offset += limit
#     count += body_hash['count']
#   end while body_hash['hasMore'] && body_hash['items'].size>0
#
#   {
#     'totalResults' => body_hash['totalResults'],
#     'count' => count,
#     'itemsSize' => items.size,
#     'offset' => original_offset,
#     'limit' => limit,
#     'items' => items,
#   }
# end
#
#
# ######### fetch full activity messages:
#
# def parse_link(link)
#   uri = URI.parse(link)
#   params = URI::decode_www_form(uri.query).to_h
#
#   uri.query = nil
#   url = uri.to_s
#
#   [url, params]
# end
#
# def expand_full_activities(msg, headers=default_headers)
#   acts = msg['activities']
#   return unless acts['hasMore']
#
#   activities_link = acts['links'].find{|link| link['rel'] == 'self'}
#   url, params = parse_link(activities_link['href'])
#
#   activities = fetch_all(url, params: params, headers: headers)
#   msg['activities'] = activities
# end
#
# def fetch_full_activity_messages(params, headers=default_headers)
#   url = File.join(config[:api_url], config[:messages_path])
#
#   #Fetch all messages and the response stored in the messages array
#   messages = fetch_all(url, params: params, headers: headers)
#   # For each message in the messages array, the function 'expand_full_activities' is
#   # called to fetch all the activities in case one message has more than 10 activities
#   messages['items'].each(&method(:expand_full_activities))
#
#   messages
# end





