require "pdf_scrap/error"
require "pdf_scrap/command"

module PdfScrap
  module Command
    class RawCommand
      COMMAND = ""
      
      def self.command
        raise CommandNotDefinedError if self::COMMAND.empty?
        self::COMMAND
      end
      
      def self.exist?
        ! self.path.nil?
      end
      
      def self.path
        `which #{self.command}`.scan(/(.+)\n/).flatten.first
      end
      
      #--------------------#
      # instance method
      
      attr_accessor :x1, :y1, :x2, :y2
      attr_accessor :pdf
      
      def initialize
        super()
        @path = self.class.path
        @params = {}
      end
      
      def [](param)
        @params[param]
      end
      
      def []=(param, value)
        @params[param] = value
      end
      
      def build
        command = "#{@path}"
        @params.each do |param, value|
          command << " -#{param} #{value}"
        end
        command
      end
      
      def rect=(value)
        value = [value].flatten
        self.x1 = value.shift
        self.y1 = value.shift
        self.x2 = value.shift
        self.y2 = value.shift
      end
    end
  end  
end
