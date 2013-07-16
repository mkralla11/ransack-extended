

module Ransack
  class Displayer

    attr_reader :show

  	def initialize(options={})
  		super()
  		@show = []
  	end

    def show=(str)
      @show << str
    end

  end
end
