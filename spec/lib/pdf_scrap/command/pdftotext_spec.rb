require "spec_helper"

describe PdfScrap::Command::Pdftotext do
  example "exist command" do
    expect(described_class.path).to be_include(described_class::COMMAND)
  end
  
  example ".new"
  
  let(:command) { described_class.new }
  
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
        command.pdf = File.join(PdfScrap::ROOT, "spec/sample/sample.pdf")
      end
      
      example "normalized command" do
        expect(built).to match(/-x #{@x1}/)
        expect(built).to match(/-y #{@y1}/)
        expect(built).to match(/-W #{@x2 - @x1}/)
        expect(built).to match(/-H #{@y2 - @y1}/)
        expect(built).to match(/sample\.pdf$/)
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
  describe "#exec"
end
