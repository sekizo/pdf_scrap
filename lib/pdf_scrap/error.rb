Dir.glob(File.join(PdfScrap::ROOT, "error/**/*.rb")).each do |f|
  require f
end
