require "version"
require 'timeout'
require 'serialport'
require 'rmodbus'
require "tracer_interface"
require 'sinatra'  
require 'json'


@a = TracerInterface.new("/dev/ttyXRUSB0")



get '/ ' do  
  'Welcome'
end  

get '/realtime' do
  TracerInterface.new("/dev/ttyXRUSB0").realtime_data.to_json
end