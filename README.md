# hatena-bookmark

[はてなブックマークAtomAPI](http://developer.hatena.ne.jp/ja/documents/bookmark/apis/atom)を手軽に使えるようにするやつです。  
OAuthに必要なtokenとかは[Hatena Developer Center](http://developer.hatena.ne.jp/ja/documents/auth/apis/oauth/consumer)を参考にして作ってください。

## Install

```
gem install hatena-bookmark
```

## Exapmle

```ruby
require 'hatena-bookmark'

hatebu = Hatena::Bookmark.new(
    consumer_key:    'examplembAdCJpQ==',
    consumer_secret: 'examplePcepenTfulWNiQfohCuw=',
    request_token:   'exampleuydlgZg==',
    request_secret:  'exampleEADUA2F4cMecY8Vlx+eY='
    )

hatebu.create(:url => 'http://www.example.com/', :comment => 'ブコメ〜〜')

puts  hatebu.feed
```

## Requirement

gem "crack", "~> 0.3.1"  
gem "oauth", "~> 0.4.5"

## Copyright

Copyright (c) 2011 kkosuge under the WTFPL license.  
See LICENSE.txt for further details.