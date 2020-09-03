require 'json'
require 'pragmatic_segmenter'

file_data = File.open('data/mein-kampf.txt')

# pragmatise the whole thing, then each element write to json
text = file_data.read.gsub("\f", "").gsub("\n", " ").gsub('"', "'")
segmenter = PragmaticSegmenter::Segmenter.new(text: text)
segmented = segmenter.segment

json_hash = segmented.to_h {|sentence| [segmented.index(sentence), sentence]}

File.open("data/mk.json","w") do |f|
  f.write(JSON.pretty_generate(json_hash))
end




