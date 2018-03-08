Gem::Specification.new do |s|
    s.name        = 'copy-cat'
    s.version     = '0.0.3'
    s.date        = '2017-03-03'
    s.summary     = "Meow !!!"
    s.description = "King cat"
    s.authors     = ["Sudhir Shrestha"]
    s.email       = 'sudhirshresthaktm@gmail.com'
    s.files       = ["lib/copy-cat.rb"]
    s.executables << 'copy-cat'

    s.add_runtime_dependency "vcr", "~> 4.0", ">= 4.0.0"
    s.add_runtime_dependency "sinatra", "~> 2.0", ">= 2.0.1"
    s.add_runtime_dependency "webmock", "~> 3.0", ">= 3.3.0"

    s.homepage    = 'https://github.com/sudhirt4/ruby-copy-cat'
    s.license     = 'MIT'
  end