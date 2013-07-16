module Ransack
  module Nodes
    class Attribute < Node
      include Bindable

      attr_reader :name
      attr_accessor :evaluatable_attribute

      delegate :blank?, :present?, :==, :to => :name
      delegate :engine, :to => :context

      def initialize(context, name = nil)
        super(context)
        self.name = name unless name.blank?
        @evaluatable_attribute = attribute_to_eval_string(name) 
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
        "Attribute <#{name}>, Evalstring <#{@evaluatable_attribute}>"
      end

      private
      def attribute_to_eval_string(query)
        debugger
        if !query.blank?
          all_associations = []

          context.base.active_record.reflect_on_all_associations.map { |assoc| all_associations << assoc.name.to_s}

          @match = all_associations.detect { |assoc| query =~ Regexp.new("^#{assoc}") }

          query = query.gsub(@match + "_", @match + "." ) if !@match.blank?

          query
        end
      end

    end
  end
end