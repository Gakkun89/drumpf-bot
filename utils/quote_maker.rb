require 'json'

HASHTAGS= %w[#maga #trump #usa #trump2020 #republican #conservative #qanon #america #makeamericagreatagain #fakenews #trumptrain #sarahpalin #confederate #donaldtrump #kag #politics #spygate #teaparty #madeinusa #lovetrump #trump #maga #america #newyork #president #whitehouse #nyc #freedom #foxnews #news #potus #life].freeze

def random_date_string
  Time.at(Time.now - rand(0..650000000)).strftime("%B %d, %Y")
end

def tweet_builder(json_path)
  quote_json = load_json(json_path)
  make_tweet(quote_json)
end

def load_json(json_path)
  # Load json 'data/mk.json'
  JSON.parse(File.read('data/mk.json'))
end

def make_tweet(quote_json)
  # Add on the quote mark (-Trump, {date})
  footer = "\n-Trump, #{random_date_string} \n"
  raw_tweet = quote_selector(quote_json) + footer
  add_hashtag(raw_tweet)
end

def quote_selector(quote_json)
  # Select a random line
  hash_length = quote_json.length
  quote_num = rand(0..hash_length)

  quote = quote_json[quote_num.to_s]
  # Make sure it is not too long, if so get next quote
  until quote.length <= 250 do
    quote_num = 0 if quote_num == (hash_length - 1)
    quote_num += 1
    quote = quote_json[quote_num.to_s]
  end
  quote
end

# Add hashtags
def add_hashtag(quote, tag_num = nil, loop_num = 0)
  return quote if loop_num == 5
  hashtag_num = tag_num || rand(0..(HASHTAGS.length - 1))
  if quote.length < 270
    hashtag_num = 0 if hashtag_num == (HASHTAGS.length - 1)
    quote = quote + " " + HASHTAGS[hashtag_num]
    hashtag_num += 1
    loop_num += 1
    add_hashtag(quote, hashtag_num, loop_num)
  else
    quote
  end
end
# Post to twitter
puts tweet_builder('data/mk.json')
