require "version"
require 'timeout'
require 'serialport'
require 'rmodbus'

class TracerInterface

  
  
  def initialize(port, baud_rate=115200, slave_id=1)
    @port = port
    @baud = baud_rate
    @client = ModBus::RTUClient.connect(@port, @baud)
    @slave = slave_id
  end
  
  def set_address(i=1)
    @slave = i
  end
  
  
  def realtime_data
    h ={}
  
    h['PV array input voltage'] = read_value('3100', 100)
    h['PV array input current'] = read_value('3101', 100)
    h['PV array input power L'] = read_value('3102', 100)
    h['PV array input power H'] = read_value('3103', 100)
    h['Battery power L'] = read_value('3106', 100)
    h['Battery power H'] = read_value('3107', 100)
    h['Load voltage'] = read_value('310C', 100)
    h['Load current'] = read_value('310D', 100)
    h['Load power L'] = read_value('310D', 100)
    h['Load power H'] = read_value('310E', 100)
    h['Battery Temperature'] = read_value('3110', 100)
    h['Temperature inside equipment'] = read_value('3111', 100)
    h['Battery SOC'] = read_value('311A', 100)
    h['Remote battery temperature'] = read_value('311B', 100)
    h['Battery\'s real rated power'] = read_value('311D', 100)
    return h
  
  end
  
  def battery_status
    h = {}
    h['Battery status'] = read_raw_value('3200')
    h['Charging equipment status'] = read_raw_value('3201')
    h['Discharging equipment status'] = read_raw_value('3202')
    return h
  end
  
  def read_value(val, d)
    return CLIENT.with_slave(1).input_registers[hex_to_dec(val)].first / d
  end

  def read_raw_value(val)
    return CLIENT.with_slave(1).input_registers[hex_to_dec(val)] 
  end
  
  def hex_to_dec(hex)
    return hex.to_i(16)
  end
    
 
end
