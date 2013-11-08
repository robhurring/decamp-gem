require "bundler/setup"
require "httparty"
require "nokogiri"

require "decamp/version"
require "decamp/response/generic"
require "decamp/parser/nokogiri"
require "decamp/schedule"

module Decamp
  extend self

  attr_accessor :response_wrappers
  self.response_wrappers = {}

  # Public: Register a custom response wrapper for any given route key.
  #
  # route   - The route key used by the decamp website
  # klass   - The response class used to wrap the request
  #
  # Examples
  #
  #   Decamp.register_wrapper_for_route('WC-NY', CustomResponseForWCNY)
  #
  # Returns nothing
  def register_wrapper_for_route(route, klass)
    self.response_wrappers[route] = klass
  end

  # Public: Get the custom response wrapper for a given route, or the default.
  #         wrapper. (Default: Decamp::Response::Generic)
  #
  # route   - The route key used by the decamp website
  #
  # Examples
  #
  #   Decamp.wrapper_for_route('WC-NY')
  #   # => CustomResponseForWCNY
  #
  # Returns the custom response class, or the generic
  def wrapper_for_route(route)
    self.response_wrappers[route] || Decamp::Response::Generic
  end
end
