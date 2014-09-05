require "fileutils"
require "pdf_scrap/command/raw_command"

class PdfScrap::Command::Pdftotext < PdfScrap::Command::RawCommand
  COMMAND = "pdftotext"
  TMP_DIR = ".tmp"
  
  def build
    command = [super]
    command << "\"#{self.pdf}\""
    command << "\"#{self.export_path}\""
    command.join(" ")
  end
  
  def execute(*args, &block)
    if block_given?
      yield(self)
      nil
    else
      self.text
    end
  end
  
  def execute!(*args, &block)
    self.make_tmp_dir
    
    `#{self.build}`
    
    result = File.open(export_path, "r") do |f|
      f.read
    end.sub(/\f$/, "")
    
    FileUtils.rm_f(export_path)
    result
  end
  
  def text(*args)
    self.execute!(*args)
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
  
  #--------------------#
  protected
  
    def make_tmp_dir
      FileUtils.mkdir_p(tmp_dir)
    end
    
    def export_path
      File.join(tmp_dir, "#{self.object_id.to_i}")
    end
    
  #--------------------#
  private
    
    def pwd
      File.dirname(File.expand_path(__FILE__))
    end
    
    def tmp_dir
      File.join(pwd, TMP_DIR)
    end
end
