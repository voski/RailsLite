require 'uri'
require 'byebug'
module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      parse_www_encoded_form(req.query_string) if req.query_string
      parse_www_encoded_form(req.body) if req.body
      @params.merge!(route_params) if !route_params.empty?
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }

    # 1. get querey string
    # 2. www_decode it to get a nested arrayw
    # 3. for each of these nested arrays parse the first key
    # 4. after parsing toss it into decoded_form
    def parse_www_encoded_form(www_encoded_form)
      decoded = URI.decode_www_form(www_encoded_form)
      decoded = parse_decoded_form(decoded)
      @params = gen_hash_from_decoded_form(decoded)
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      regex = /\]\[|\[|\]/
      key.split(regex)
    end

    def parse_decoded_form(decoded_form)
      result = []
      decoded_form.each do |keys, val|
        result << [parse_key(keys), val]
      end
      result
    end

      def gen_hash_from_decoded_form(decoded_form)
        result = {}

        decoded_form.each do |keys, val|
          current_node = result
          keys.each_with_index do |key, i|
            if i == keys.length - 1
              current_node[key] = val
            else
              unless current_node[key].is_a?(Hash)
                current_node[key] = {}
              end
              current_node = current_node[key]
            end
          end
        end
        result
      end
  end
end
