# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blirb/version"

Gem::Specification.new do |s|
  s.name        = "blirb"
  s.version     = Blirb::VERSION
  s.authors     = ["ian asaff"]
  s.email       = ["ian.asaff@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{command line ruby tutorial adventure}
  s.description = %q{ruby adventure awaits! also, you will learn stuff.}

  s.rubyforge_project = "blirb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_development_dependency "rcov"
  # s.add_runtime_dependency "rest-client"
end
