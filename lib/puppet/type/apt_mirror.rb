require 'puppet/property/ordered_list'

Puppet::Type.newtype(:apt_mirror) do

  @doc = "Manage the content of /etc/apt/mirrors.list"

  ensurable 

  newparam(:name) do
    desc "The apt repo to mirror."
    isnamevar
  end

  newproperty(:arch) do
    desc "The architecture to mirror. If this is nil, all architectures will be mirrored."
      newvalues("i386","i686","amd64","ia64","powerpc","hppa") 
  end

  newproperty(:deb) do
    desc "If arch is nil, this should return 'deb'. Otherwise, return 'deb-$arch'"
    defaultto { @resource.value(:arch).nil? ? "deb" : "deb-#{@resource.value(:arch)}" }
  end

  newproperty(:target) do
    desc "Location of the mirrors.list file."
    defaultto {
      if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
        @resource.class.defaultprovider.default_target
      else
        nil
      end
    }
  end

  newproperty(:uri) do
    desc "Location of the remote mirror."
    #FIXME validate uri here
  end

  newproperty(:sections, :parent => Puppet::Property::OrderedList) do
    desc "Sections to mirror. Multiple sections must be specified as an array."

    def delimiter
      " "
    end

    def inclusive?
      true
    end

    validate do |value|
      raise Puppet::Error, "Sections can not include whitespace" if value =~ /\s/
      raise Puppet::Error, "Section can not be an empty string." if value =~ /^\s*$/
    end

  end

end
