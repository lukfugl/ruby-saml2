require 'saml2/bindings/http_post'

module SAML2
  class Endpoint < Base
    attr_reader :location, :binding

    def initialize(location = nil, binding = Bindings::HTTP_POST::URN)
      @location, @binding = location, binding
    end

    def ==(rhs)
      location == rhs.location && binding == rhs.binding
    end

    def from_xml(node)
      super
      @location = node['Location']
      @binding = node['Binding']
    end

    def build(builder, element)
      builder['md'].__send__(element, 'Location' => location, 'Binding' => binding)
    end

    class Indexed < Endpoint
      include IndexedObject

      def initialize(location = nil, index = nil, is_default = nil, binding = Bindings::HTTP_POST::URN)
        super(location, binding)
        @index, @is_default = index, is_default
      end

      def eql?(rhs)
        location == rhs.location &&
            binding == rhs.binding && super
      end
    end
  end
end
