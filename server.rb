require "bundler/setup"
require 'timeout'
require 'serialport'
require 'rmodbus'
require "tracer_interface"
require 'sinatra'  
require 'json'

set :bind, '0.0.0.0'
set :port, 9000
configure { set :server, :puma }

set :tty,  "/dev/ttyXRUSB0"

get '/' do  
  "Welcome"
end  

get '/realtime' do
  TracerInterface.new(settings.tty).realtime_data.to_json
end

get '/rated' do
  TracerInterface.new(settings.tty).rated_datum.to_json
end

get '/statistical' do
  TracerInterface.new(settings.tty).statistical_params.to_json
end