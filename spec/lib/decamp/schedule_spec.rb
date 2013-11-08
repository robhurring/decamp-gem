require 'spec_helper'

describe Decamp::Schedule do
  it_should_behave_like "a scraped schedule", 'WC-NY'
  it_should_behave_like "a scraped schedule", 'NY-WC'
end