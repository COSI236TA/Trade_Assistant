require 'minitest/autorun'
require 'minitest/spec'

require_relative '../lap'

describe Lap do

    it "could be started" do
        Lap.new.start
        Lap.new.respond_to?(:start).must_equal true
    end

end