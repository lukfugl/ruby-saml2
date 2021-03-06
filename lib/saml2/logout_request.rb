require 'saml2/name_id'
require 'saml2/request'

module SAML2
  class LogoutRequest < Request
    attr_accessor :name_id, :session_index

    def self.initiate(sso, issuer, name_id, session_index = nil)
      logout_request = new
      logout_request.issuer = issuer
      logout_request.destination = sso.single_logout_services.first.location
      logout_request.name_id = name_id
      logout_request.session_index = session_index

      logout_request
    end

    def name_id
      @name_id ||= (NameID.from_xml(xml.at_xpath('saml:NameID', Namespaces::ALL)) if xml)
    end

    def session_index
      @session_index ||= (load_string_array(xml,'samlp:SessionIndex') if xml)
    end

    private

    def build(builder)
      builder['samlp'].LogoutRequest(
          'xmlns:samlp' => Namespaces::SAMLP,
          'xmlns:saml' => Namespaces::SAML
      ) do |logout_request|
        super(logout_request)

        name_id.build(logout_request)

        Array(session_index).each do |session_index_instance|
          logout_request['samlp'].SessionIndex(session_index_instance)
        end
      end
    end
  end
end
