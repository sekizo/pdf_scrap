require "pdf_scrap/command/raw_command"

class PdfScrap::Command::Pdftotext < PdfScrap::Command::RawCommand
  COMMAND = "pdftotext"
  
  def build
    command = super
    command << " #{self.pdf}"
    command
  end
  
  def x1=(value)
    self[:x] = value
  end
  
  def y1=(value)
    self[:y] = value
  end
  
  def x2=(value)
    self[:W] = value - (self[:x]||0)
  end
  
  def y2=(value)
    self[:H] = value - (self[:y]||0)
  end
  
  def height=(value)
    self[:H] = value
  end
  
  def width=(value)
    self[:W] = value
  end
end
