class GoogleService
  def speech_to_text(audio_path)
    speech = Google::Cloud::Speech.new

    audio_file = File.binread audio_path
    config     = { encoding: :FLAC,
                   audio_channel_count: 2,
                   sample_rate_hertz: 22050,
                   language_code: "en-US" }
    audio      = { content: audio_file }

    response = speech.recognize config, audio

    results = response.results

    if results.empty?
      "No Matching Text Found"
    else
      results.first.alternatives.first.transcript
    end
  end
end
