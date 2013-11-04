require "bundler/setup"
require "httparty"
require "nokogiri"

require "decamp/version"
require "decamp/response/base"
require "decamp/parser/nokogiri"
require "decamp/scraper"

module Decamp
  extend self

  attr_accessor :response_wrappers
  self.response_wrappers = {}

  def register_wrapper_for_route(route, klass)
    self.response_wrappers[route] = klass
  end

  def wrapper_for_route(route)
    self.response_wrappers[route] || Decamp::Response::Base
  end
end
