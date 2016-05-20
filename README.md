##  Directly calculate from trey_db:

1. config trey db:

 ``` bash
vim by_db/trey_db.yml
```

2. calculate follower counts:

 ```bash
bundle install
bundle exec ruby by_db/calculate_db.rb
```


#### references

* related source files: 'by_db' dir, 'Gemfile'
* trey_db_schema: references/trey_db_schema.sql

#### todo

1. need to confirm: 'page_fans'(fb), 'follower_count'(twitter, youtube) also means 'total_follower'; otherwise we need to sum all items rather than a single day's items
2. add calculation logic of 'youtube'(youtube_channel_metrics_days): maybe sum all 'subscribers_gained'