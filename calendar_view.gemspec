# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "calendar_view/version"

Gem::Specification.new do |s|
  s.name        = "calendar_view"
  s.version     = CalendarView::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Wojciech Todryk"]
  s.email       = ["wojciech@todryk.pl"]
  s.homepage    = "http://todryk.pl/calendar-view"
  s.summary     = %q{Calendar view}
  s.description = %q{Extends Rails application of calendar view}

  s.rubyforge_project = "calendar_view"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('rails', '>= 3.0.0')
end
