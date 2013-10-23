# coding: UTF-8
Configus.build Rails.env do
  env :production do
    website_url 'http://teaserlead.com'

    timestamp_0 '1970-01-01 00:00:00+00'
    date_0      '1970-01-01'

    roles [:user, :webmaster, :advertisor, :admin]

    teaser do
      dimensions do
        thumb_50 { w 50; h 50}
        thumb_100 { w 100; h 100}
        thumb_200 { w 200; h 200}
      end
      max_text_length 75
    end
  end

  env :development, parent: :production do
    website_url 'http://teaserlead.dev'
  end

  env :test, parent: :production do
    website_url 'http://example.com'
  end

end
