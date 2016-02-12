module APIMatchers
  module HTTPStatusCode
    class BeNotAcceptable < Base
      def expected_status_code
        406
      end

      def failure_message
        %Q{expected that '#{@http_status_code}' to be Not Acceptable with the status '#{@http_status_code}'.}
      end

      def failure_message_when_negated
        %Q{expected that '#{@http_status_code}' to NOT be Not Acceptable.}
      end

      def description
        "be Not Acceptable with the status '406'"
      end

      # RSpec 2 compatibility:
      alias_method :failure_message_for_should, :failure_message
      alias_method :failure_message_for_should_not, :failure_message_when_negated
    end
  end
end
