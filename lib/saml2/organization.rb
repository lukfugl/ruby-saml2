require 'saml2/base'
require 'saml2/localized_name'
require 'saml2/namespaces'

module SAML2
  class Organization < Base
    attr_reader :name, :display_name, :url

    def from_xml(node)
      name.from_xml(node.xpath('md:OrganizationName', Namespaces::ALL))
      display_name.from_xml(node.xpath('md:OrganizationDisplayName', Namespaces::ALL))
      url.from_xml(node.xpath('md:OrganizationURL', Namespaces::ALL))
    end

    def initialize(name = nil, display_name = nil, url = nil)
      @name = LocalizedName.new('OrganizationName', name)
      @display_name = LocalizedName.new('OrganizationDisplayName', display_name)
      @url = LocalizedName.new('OrganizationURL', url)
    end

    def build(builder)
      builder['md'].Organization do |organization|
        @name.build(organization)
        @display_name.build(organization)
        @url.build(organization)
      end
    end
  end
end
