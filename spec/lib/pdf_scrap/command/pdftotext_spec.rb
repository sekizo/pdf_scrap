require "spec_helper"

describe PdfScrap::Command::Pdftotext do
  let(:pdf) { File.join(PdfScrap::ROOT, "spec/sample/sample.pdf") }
  let(:command) { described_class.new }
  
  describe ".path" do
    example "exist command" do
      expect(described_class.path).to be_include(described_class::COMMAND)
    end
  end
  
  describe ".new"
  
  describe "#[param]=value" do
    example "update raw parameter" do
      expect do
        command[:x] = 10
      end.to change{ command[:x] }.from(nil).to(10)
    end
  end
  
  describe "#build" do
    let(:built) { command.build }
    
    context "no params" do
      example("start with path") { expect(command.build).to match(/^#{described_class.path}/) }
    end
    
    context "specify params" do
      before(:each) do
        @x1, @y1, @x2, @y2 = 10, 20, 30, 40
        
        command.x1 = @x1
        command.y1 = @y1
        command.x2 = @x2
        command.y2 = @y2
        command.pdf = pdf
      end
      
      example "normalized command" do
        expect(built).to match(/-x #{@x1}/)
        expect(built).to match(/-y #{@y1}/)
        expect(built).to match(/-W #{@x2 - @x1}/)
        expect(built).to match(/-H #{@y2 - @y1}/)
        expect(built).to match(/sample\.pdf\"/)
      end
      
      context "specify width" do
        before(:each) do
          @width = @x2 - @x1 + 10
          command.width = @width
        end
        
        example("update width") { expect(built).to match(/-W #{@width}/) }
      end
      
      context "specify height" do
        before(:each) do
          @height = @y2 - @y1 + 10
          command.height = @height
        end
        
        example("update height") { expect(built).to match(/-H #{@height}/) }
      end
      
    end # context "specify params"
  end # describe "#build"
  
  describe "#execute" do
    let(:result) { command.execute }
    before(:each) do
      command.pdf = pdf
      
      @lines = 12
      
      @x = 50
      @y = 36
      @w = 120
      @h = 32
      
      @step = 31
    end
    
    example "convert to text" do
      expect(result).to be_a(String)
    end
    
    example "block given" do
      texts = []
      
      command.execute do |com|
        (1.. @lines).each do |m|
          com.x1 = @x
          com.y1 = @y
          com.x2 = @x + @w
          com.y2 = @y + @h
          
          texts << com.text
          
          @y += @step
        end
      end
      
      expect(texts.size).to be @lines
    end
  end
end
