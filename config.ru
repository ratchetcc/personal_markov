
require 'rack/cache'
require './app'

use Rack::Cache, :metastore => 'heap:/', :entitystore => 'heap:/', :verbose => true

run Markov::App