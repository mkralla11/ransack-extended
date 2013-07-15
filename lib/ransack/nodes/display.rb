module Ransack
  module Nodes
    class Display < Node
      attr_accessor :display

      def initialize(context, show = nil)
        super(context)
        @display = display
      end


    end
  end
end