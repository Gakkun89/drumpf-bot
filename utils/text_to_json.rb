require 'json'
require 'pragmatic_segmenter'

file_data = File.open('data/mein-kampf.txt')

# pragmatise the whole thing, then each element write to json


File.open('mktest.txt', 'w') do |f|
  spaced = file_data.read.gsub("\f", "").gsub("\n", " ")
  segmented = PragmaticSegmenter::Segmenter.new(text: spaced)

  f.write segmented.segment

end
