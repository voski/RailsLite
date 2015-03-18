require 'uri'


def parse_key(key)
  regex = /\]\[|\[|\]/
  string.split(regex)
end

def recursive_hash
  Hash.new {|h,k| h[k] = recursive_hash }
end

test_string = "user[address][street]=main&user[address][zip]=89436"
URI.decode_www_form(test_string).each do |param|
    {param[-2] => param[-1]}
end

def build_nested_hash(param)

keys = parse_key(param[0])
val = param[1]


h = recursive_hash

keys.each.with_index do |key, i|

end

  => [["user[address][street]", "main"], ["user[address][zip]", "89436"]]

  [90] pry(main)> decoded[0][0].split(regex)
  => ["user", "address", "street"]



"user[address][street]=main&user[address][zip]=89436"
test_string = "cat[gizmo][uncle][body][bobby][meow]"
