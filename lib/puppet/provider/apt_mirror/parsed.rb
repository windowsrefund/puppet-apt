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

  record_line :parsed, 
		:fields => %w{name uri}
		#:match  => /^(\S+) (\S+)$/

	def dir_perm
		0700
	end

	def file_perm
		0644
	end

	#def flush
	#	unless File.exist?(dir = File.dirname(target))
	#		Puppet.debug "Creating #{dir}"
	#		Dir.mkdir(dir, dir_perm)
	#	end

	#	File.chmod(file_perm, target)

	#end

end

