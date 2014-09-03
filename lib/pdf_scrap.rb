require "pdf_scrap/version"

PdfScrap::LIB = File.dirname(File.expand_path(__FILE__))
PdfScrap::ROOT = File.dirname(PdfScrap::LIB)

Dir.glob(File.join(PdfScrap::LIB, "**/*.rb")).each do |f|
  require f
end

module PdfScrap
  # Your code goes here...
end
