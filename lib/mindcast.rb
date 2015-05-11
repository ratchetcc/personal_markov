
require 'json'
require 'yaml'
require 'excon'

# The top-level module for the Majordomus API
module Mindcast
  
  require 'mindcast/version'
  require 'mindcast/exceptions'
  require 'mindcast/api/endpoint'
  require 'mindcast/api/assets'
  require 'mindcast/api/status'
  
  def etcd_url
    ENV['ETCD_URL'] || "http://127.0.0.1:4001"
  end
  
  module_function :etcd_url
  
end
