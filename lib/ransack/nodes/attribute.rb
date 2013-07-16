module Ransack
  module Nodes
    class Attribute < Node
      include Bindable

      attr_reader :name
      attr_accessor :eval_attribute

      delegate :blank?, :present?, :==, :to => :name
      delegate :engine, :to => :context

      def initialize(context, name = nil, display=nil)
        super(context)
        self.name = name unless name.blank?
        self.eval_attribute = attribute_to_eval_string(name, display) 
        self.display = display
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
        "Attribute <#{name}>, EvalAttribute <#{eval_attribute}>, Display <#{display}>"
      end

      private
      def attribute_to_eval_string(query)
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