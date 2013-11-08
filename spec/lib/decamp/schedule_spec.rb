require 'spec_helper'

describe Decamp::Schedule do
  it_should_behave_like "a scraped schedule", 'WC-NY'
  it_should_behave_like "a scraped schedule", 'NY-WC'
  
  it_should_behave_like "a scraped schedule", 'WO-NY'
  it_should_behave_like "a scraped schedule", 'NY-WO'
end