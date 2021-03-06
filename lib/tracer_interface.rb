require "tracer_version"
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
  
  def rated_datum
    h ={}
    h['array rated voltage'] = read_value('3000', 100)
    h['array rated current'] = read_value('3001', 100)
    h['array rated power L'] = read_value('3002', 100)
    h['array rated power H'] = read_value('3003', 100)
    h['Battery rated voltage'] = read_value('3004', 100)
    h['Battery rated current'] = read_value('3005', 100)
    h['Battery rated power L'] = read_value('3006', 100)
    h['Battery rated power H'] = read_value('3007', 100)
    h['Charging mode'] = read_value('3008', 100)
    h['Rated current of load'] = read_value('300E', 100)
    return h
    
  end
  
  
  def statistical_params
    h ={}
  
    h['Maximum PV voltage today'] = read_value('3300', 100)
    h['Minimum PV voltage today'] = read_value('3301', 100)
    h['Maximum battery voltage today'] = read_value('3302', 100)
    h['Minimum battery voltage today'] = read_value('3303', 100)
    h['Consumed energy today L'] = read_value('3304', 100)
    h['Battery power H'] = read_value('3305', 100)
    h['Consumed energy today H'] = read_value('3306', 100)
    h['Consumed energy this month L'] = read_value('3307', 100)
    h['Consumed energy this month H'] = read_value('3308', 100)
    h['Consumed energy this year L'] = read_value('3309', 100)
    h['Consumed energy this year H'] = read_value('330A', 100)
    h['Total consumed energy L'] = read_value('330B', 100)
    h['Total consumed energy H'] = read_value('330C', 100)
    h['Generated energy today L'] = read_value('330D', 100)
    h['Generated energy today H'] = read_value('330E', 100)
    
    h['Generated energy this month L'] = read_value('330E', 100)
    h['Generated energy this month H'] = read_value('330F', 100)
    h['Generated energy this year L'] = read_value('3310', 100)
    h['Generated energy this year H'] = read_value('3311', 100)
    h['Total generated energy L'] = read_value('3312', 100)
    h['Total Generated energy H'] = read_value('3313', 100)
    h['Battery voltage'] = read_value('331A', 100)
    h['Battery current L'] = read_value('331B', 100)
    h['Battery current H'] = read_value('331C', 100)
 
    return h
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
    return @client.with_slave(@slave).input_registers[hex_to_dec(val)].first / d
  end

  def read_raw_value(val)
    return @client.with_slave(@slave).input_registers[hex_to_dec(val)] 
  end
  
  def hex_to_dec(hex)
    return hex.to_i(16)
  end
    
 
end
