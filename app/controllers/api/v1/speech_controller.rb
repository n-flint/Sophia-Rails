class Api::V1::SpeechController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    File.open('./app/assets/audio/speech.caf', 'wb') do |f|
        f.write request.body.read
    end

    system('ffmpeg -i ./app/assets/audio/speech.caf -r 25 -acodec flac -ar 22050 -y -s 320x240 ./app/assets/audio/speech.flac')

    text = GoogleService.new.speech_to_text('./app/assets/audio/speech.flac')

    render json: { text: text }
  end
end
