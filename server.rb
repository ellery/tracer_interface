require "bundler/setup"
require 'timeout'
require 'serialport'
require 'rmodbus'
require "tracer_interface"
require 'sinatra'  
require 'json'


get '/' do  
  "Welcome"
end  

get '/realtime' do
  TracerInterface.new("/dev/ttyXRUSB0").realtime_data.to_json
end