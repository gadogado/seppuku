# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{seppuku}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Geoff Ereth"]
  s.date = %q{2010-07-01}
  s.default_executable = %q{seppuku}
  s.description = %q{a ruby cmdline utility that simplifies killing procs listed in your ps table}
  s.email = %q{geoffereth @nospamplease@ gmail com}
  s.executables = ["seppuku"]
  s.extra_rdoc_files = ["README", "bin/seppuku", "lib/seppuku.rb"]
  s.files = ["README", "Rakefile", "bin/seppuku", "lib/seppuku.rb", "Manifest", "seppuku.gemspec"]
  s.homepage = %q{http://github.com/gadogado/seppuku}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Seppuku", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{seppuku}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{a ruby cmdline utility that simplifies killing procs listed in your ps table}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
