require 'spec_helper'

describe Decamp::Schedule do
  it_should_behave_like "a schedule with routes", 'WC-NY'
  it_should_behave_like "a schedule with routes", 'NY-WC'
  
  it_should_behave_like "a schedule with routes", 'WO-NY'
  it_should_behave_like "a schedule with routes", 'NY-WO'
end