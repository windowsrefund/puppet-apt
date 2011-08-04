require 'puppet/provider/parsedfile'
default_target = '/etc/apt/mirror.list'

Puppet::Type.type(:apt_mirror).provide(
  :parsed, 
  :parent => Puppet::Provider::ParsedFile, 
  :filetype => :flat,
  :default_target => default_target) do

  desc "The apt-mirror provider which uses the ParsedFile class"

  text_line :comment, :match => /^#/
  text_line :blank, :match => /^\s*$/

  record_line :parsed, :fields => %w{deb uri sections}

end

