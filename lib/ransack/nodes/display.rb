module Ransack
  module Nodes
    class Display < Node
      attr_accessor :display

      def initialize(context, show = nil)
        super(context)
        debugger
        @display = show
      end


    end
  end
end