require 'terminal-table'

module Koine
  class Profiler
    module Reporters
      class Cli
        def initialize(output = STDOUT, table = Terminal::Table.new)
          @output = output
          @table = table
        end

        def report(entries)
          @table << ['Entry', 'Elapsed Time', '# of calls']

          entries.each do |entry|
            @table << [entry.name, entry.elapsed_time, entry.hits]
          end

          @output << @table
        end
      end
    end
  end
end
