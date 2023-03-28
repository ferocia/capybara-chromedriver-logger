module Capybara
  module Chromedriver
    module Logger
      class TestHooks
        def self.before_example!
          collector = Capybara::Chromedriver::Logger::Collector.new
          collector.flush_logs!
        end

        def self.after_example!
          collector = Capybara::Chromedriver::Logger::Collector.new
          collector.flush_and_check_errors!
        end

        def self.for_rspec!
          ::RSpec.configure do |config|
            %i[feature system].each do |type|
              config.before :each, type: type do
                Capybara::Chromedriver::Logger::TestHooks.before_example!
              end
              config.after :each, type: type do
                Capybara::Chromedriver::Logger::TestHooks.after_example!
              end
            end
          end
        end
      end
    end
  end
end
