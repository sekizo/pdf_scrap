require "spec_helper"

describe PdfScrap::Command::RawCommand do
  describe ".exist?" do
    example "raise error" do
      expect do
        described_class.exist?
      end.to raise_error(CommandNotDefinedError)
    end
  end
  
  describe ".command" do
    example "raise error" do
      expect do
        described_class.command
      end.to raise_error
    end
  end
  
  context "instance method" do
    before :each do
      allow(described_class).to receive(:command).and_return(" ")
      allow(described_class).to receive(:exist?).and_return(true)
      allow(described_class).to receive(:path).and_return("stub_command")
    end
    
    example ".new"
    
    let(:command) { described_class.new }
    let(:rect) { [1, 2, 3, 4] }
    
    describe "#[param]=value" do
      example "update raw parameter" do
        expect do
          command[:x] = 10
        end.to change{ command[:x] }.from(nil).to(10)
      end
    end
    
    describe "#rect=" do
      example "update params" do
        expect { command.rect = rect }.to change { command.y2 }.from(nil).to(rect[3])
      end
    end
    
    context "no params" do
      example "#build" do
        expect(command.build).to eq "#{described_class.path}"
      end
    end
    
    context "specify params" do
      before(:each) do
        command[:x1] = 10
        command[:y1] = 20
        command[:x2] = 30
        command[:y2] = 40
      end
      
      example "#build" do
        built = command.build
        expect(built).to match(/-x1 10/)
        expect(built).to match(/-y1 20/)
        expect(built).to match(/-x2 30/)
        expect(built).to match(/-y2 40/)
      end
    end
    
    example "#exec"
  end # context "instance method"
end
