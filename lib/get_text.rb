
require 'uuidtools'


module GetText
  def self.from_pdf(filename)
    tmpfile = UUIDTools::UUID.random_create.to_s + '.mp3'
    system("pdftotext #{filename} #{tmpfile}")
    txt = self.from_txt(tmpfile)
    Thread.new { system("rm #{tmpfile}") }
    txt
  end
  
  def self.from_txt(filename)
    open(filename, 'r').read
  end
end
