# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "saml2/version"

Gem::Specification.new do |s|
  s.name = 'saml2'
  s.version = SAML2::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Cody Cutrer"]
  s.email = "cody@instructure.com'"
  s.homepage = "https://github.com/instructure/ruby-saml2"
  s.summary = "SAML 2.0 Library"
  s.description = <<-DESC
  The saml2 library is yet another SAML library for Ruby, with
  an emphasis on _not_ re-implementing XML, especially XML Security,
  _not_ parsing via Regex or generating XML by string concatenation,
  _not_ serializing/re-parsing multiple times just to get it into
  the correct format to sign or validate.

  For now, it provides a clean interface for implementing an IdP,
  but not an SP.
  DESC
  s.license = "MIT"
  s.files = Dir["{app,lib,schemas}/**/*"] + ["Rakefile"]
  s.test_files = Dir["spec/**/*"]

  # Very specifically at least 1.5.8 - they fixed a bug with namespaces
  # on root elements with XML::Builder in that release
  s.add_dependency 'nokogiri', ">= 1.5.8", "< 1.7"
  s.add_dependency 'nokogiri-xmlsec-me-harder', "~> 0.9", ">= 0.9.3pre"
  s.add_dependency 'activesupport', ">= 3.2", "< 5.1"

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
end
