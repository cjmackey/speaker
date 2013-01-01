
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'tts'
require 'get_text'
require 'tactful_tokenizer'

class Speaker
  attr_accessor :sentences, :position
  
  def initialize(opts={})
    
    if opts[:filename]
      if opts[:filename] =~ /\.pdf$/
        opts[:pdf] = opts[:filename]
      elsif opts[:filename] =~ /\.txt$/
        opts[:txt] = opts[:filename]
      end
    end
    
    txt = nil
    if opts[:pdf]
      txt = GetText.from_pdf(opts[:pdf])
    elsif opts[:txt]
      txt = GetText.from_txt(opts[:txt])
    end
    raise "no text!" unless txt
    
    @sentences = split_sentences(txt)
    @position = 0
  end
  
  def play_all
    while @position < @sentences.size
      play_one
    end
  end
  
  def play_one
    sentence = @sentences[@position]
    puts sentence
    TTS.tts(sentence)
    @position += 1
  end
  
  def split_sentences(txt)
    m = TactfulTokenizer::Model.new
    paragraphs = split_paragraphs(txt)
    sentences = []
    paragraphs.each do |paragraph|
      sentences += m.tokenize_text(paragraph)
    end
    sentences.each do |sentence|
      # awkwardly removing ligatures, loosely based on
      # http://en.wikipedia.org/wiki/Typographic_ligature
      # 
      # There has to be a better way of doing this though, right?
      sentence.gsub!("\u00C6",'AE')
      sentence.gsub!("\u00E6",'ae')
      sentence.gsub!("\u0152",'OE')
      sentence.gsub!("\u0153",'oe')
      sentence.gsub!("\u0132",'IJ')
      sentence.gsub!("\u0133",'ij')
      sentence.gsub!("\u1D6B",'ue')
      sentence.gsub!("\uFB00",'ff')
      sentence.gsub!("\uFB01",'fi')
      sentence.gsub!("\uFB02",'fl')
      sentence.gsub!("\uFB03",'ffi')
      sentence.gsub!("\uFB04",'ffl')
      sentence.gsub!("\uFB05",'ft')
      sentence.gsub!("\uFB06",'st')
    end
    sentences
  end
  
  # break by paragraph (designated by at least two new lines in a row)
  def split_paragraphs(txt)
    paragraphs = []
    cur_paragraph = ''
    txt.lines.each do |line|
      line = line.strip
      if line.size > 0
        cur_paragraph += ' ' + line
      else
        paragraphs << cur_paragraph
        cur_paragraph = ''
      end
    end
    paragraphs << cur_paragraph
    paragraphs = paragraphs.find_all { |p| p.size > 0 }
    paragraphs
  end
  
end
