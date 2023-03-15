require "uri"
require "net/http"
require 'thread'

module SeatableRuby
  class RequestsLimiter
    class << self
      attr_accessor :counter
    end
    # attr_accessor :counter # it SeatableRuby::RequestsLimiter.requests returns the empty array

    DEFAULT_LIMITER_PER_SECOND = 5 # check everytime

    def initialize(requests_per_second: nil, sleeper: nil)
      @requests_per_second = requests_per_second
      # @sleeper = sleeper || ->(seconds) { sleep(seconds) } #
      @mutex = Mutex.new
      clear
    end

    # def counter
    #   @counter ||= {}
    # end

    def run(url, limits)
      @mutex.synchronize do
        p counter
        p '--+++'
        counter[url] = { times: [] } if counter[url].nil?
        counter[url][:times] << Process.clock_gettime(Process::CLOCK_MONOTONIC)
        p counter
        p '1'
        limits.each do |time_period, requests_nums|
          p 'xxx'
          next if counter[url][:wait].nil?

          time_diffs = counter[url].last - counter[url].first
          p counter[url][:times].size
          p time_diffs
          p time_diffs >= time_period.to_i
          counter[url][:wait] = time_diffs if counter[url][:times].size >= requests_nums && time_diffs >= time_period.to_i
        end
        counter[url][:wait]
        p counter
        p '2'
         # if (wait = too_many_requests_in_time_period?(url, limits))
         # end
      end
    end

    def clear
      self.class.counter = {}
    end

    private

    def counter
      self.class.counter
    end

    def too_many_requests_in_last_second?(url)
      counter[url] = 0 if counter[url].nil?
      counter[url] += 1
      counter[url] < 5 #(@requests_per_second || DEFAULT_LIMITER_PER_SECOND)
    end

    # def too_many_requests_in_time_period?(url, limits)
    #   # { 'some_url/1' => { times: [times], wait: 'numb in seconds format' }, ... } if wait is present => return 429 status
    #   # and return message - how many times remains to continue work with requests
    #
    #   counter[url] = { times: [] } if counter[url].nil?
    #   counter[url][:times] << Process.clock_gettime(Process::CLOCK_MONOTONIC)
    #   limits.each do |time_period, requests_nums|
    #     next if counter[url][:wait].nil?
    #
    #     time_diffs = counter[url].last - counter[url].first
    #     counter[url][:wait] = time_diffs if counter[url][:times].size >= requests_nums && time_diffs >= time_period.to_i
    #   end
    #   counter[url][:wait]
    # end
  end
end