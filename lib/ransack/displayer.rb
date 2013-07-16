

module Ransack
  class Displayer

    attr_reader :displayer

  	def initialize(context, options={})
  		super()
  		@displayer = []
  	end

    def displayer=(str)
      @displayer << str
    end

  end
end
