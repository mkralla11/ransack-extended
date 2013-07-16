module Ransack
  class Displayer < Ransack::Search

    attr_reader :displayer

  	def initialize(context, displayer = [])
  		super(context)
  		@displayer = displayer
  	end

    def displayer=(str)
      @displayer << str
    end

  end
end
