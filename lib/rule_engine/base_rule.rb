#BaseRule
#Usage:
#    Initialize -> add_triggers -> ready -> is_met?
#    It does not check the validity of ticker

require 'rubygems'
require 'yahoo_stock'

class BaseRule

  #for test only
  attr_accessor :condition, :triggers, :ticker

  #Only support single ticker query
  #ticker: string
  def initialize ticker
    @ticker = ticker
    @condition = Hash.new
    @triggers = Hash.new
  end

  #raw_triggers: { :property => [:rel, target] }
  def add_triggers raw_triggers
    puts raw_triggers
    raw_triggers.each do |k, v|
      @triggers[k] = triggerize(*v)
    end
  end

  #ticker: string, the ticker representation of the stock. e.g. GOOG
  def get_condition
    @condition
  end

  #Last step for match
  def ready
    quote = DataPool::DataPool.query(@ticker)
    #need to convert the queried value to integer
    begin
      quote.each { |k, v| @condition[k] = v.to_f }
      @condition[:updated_time] = Time.new
    rescue
      puts "Query failed."
      return false
    end
    return true
  end

  #rel: :up or :down
  #target: numeric
  def triggerize rel, target
    raise "Wrong rel, expecting up or down" if rel == nil
    raise "Wrong target, expecting float" if target == nil
    if rel == 'up'
      return lambda { |x| x >= target }
    elsif rel == 'down'
      return lambda { |x| x <= target }
    end
  end

  #condition: { :property => value }
  #return ture if all triggers are met
  def is_met?
    return false if @condition.size == 0
    results = @triggers.map do |ind, trigger|
      cond = @condition[ind]
      if cond == nil
        false
      else
        trigger.call @condition[ind]
      end
    end
    return results.reduce(true) { |c, v| c && v }
  end
end
