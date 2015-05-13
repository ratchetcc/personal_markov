require 'rubygems'
require 'bundler'
require 'json'

# Setup load paths
Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

# load ENV from a .env file, development only!
#require 'dotenv'
#Dotenv.load

# Require sinatra basics
require 'sinatra/base'
require "sinatra/reloader"

# our modules etc
require 'markov'

module Markov
  class App < Sinatra::Application
      
    configure do
      # configure app
    end
    
    # include other apps, modules etc
    use Markov::Status
    use Markov::Tweet
    
  end
end