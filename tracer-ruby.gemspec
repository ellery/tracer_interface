# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "tracer-ruby"
  spec.version       = Tracer::Ruby::VERSION
  spec.authors       = ["Ellery Durgin"]
  spec.email         = ["ejd91717@gmail.com"]
  spec.summary       = %q{ tracer-ruby is a gem to interact with EPEVER Tracer solar charge controllers.}
  spec.description   = %q{tracer-ruby uses rubyserial and rmodbus to interact with EPEVER Tracer A series controllers, tested on the 3120A with the XRCOM USB to RS-485 adaptor }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "timeout", "~> 0.0.1"
  spec.add_development_dependency "serialport", "~> 1.3.0"
  spec.add_development_dependency "rmodbus", "~> 1.3.2"
  
end
