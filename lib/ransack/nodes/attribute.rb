module Ransack
  module Nodes
    class Attribute < Node
      include Bindable

      attr_reader :name

      delegate :blank?, :present?, :==, :to => :name
      delegate :engine, :to => :context

      def initialize(context, name = nil)
        super(context)
        self.name = name unless name.blank?
        self.evaluatable_attribute = attribute_to_eval_string(name)
      end

      def name=(name)
        @name = name
        context.bind(self, name) unless name.blank?
      end

      def valid?
        bound? && attr
      end

      def type
        if ransacker
          return ransacker.type
        else
          context.type_for(self)
        end
      end

      def eql?(other)
        self.class == other.class &&
        self.name == other.name
      end
      alias :== :eql?

      def hash
        self.name.hash
      end

      def persisted?
        false
      end

      def inspect
        "Attribute <#{name}>"
      end

      private
      def attribute_to_eval_string(query, str="")
        debugger
        query = query.split("_")


      end

    end
  end
end