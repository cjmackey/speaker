

require 'uuidtools'
require 'espeak-ruby'

include ESpeak

module TTS
  
  def self.tts(text, opts={})
    filename = opts[:filename] || UUIDTools::UUID.random_create.to_s + '.mp3'
    espeak(filename, :text => text, :quiet => true)
    `mplayer -quiet #{filename} 2>&1`
    Thread.new { system("rm #{filename}") }
  end
end

