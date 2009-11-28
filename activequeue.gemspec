Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "activequeue"
  s.version = "3.0.pre"
  s.date = "2009-11-23"
  s.summary = "Queue interface used by the Rails framework."
  s.description = %q{Standard queue interface so Rails applications can send messages to queues}

  s.files = Dir['CHANGELOG', 'README', 'lib/**/*']
  s.require_path = 'lib'
  s.has_rdoc = true

  s.author = "Anthony Eden"
  s.email = "anthonyeden@gmail.com"
  s.homepage = "http://www.rubyonrails.org"
end
