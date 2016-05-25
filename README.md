##  Directly calculate from trey_db:

1. config trey db:

 ``` bash
vim config/trey_db.yml
```

2. dump follower counts from trey_db to 'output/db_follower_counts.yml':

 ```bash
bundle exec ruby fetch_trey_follower_counts.rb
```

3. fetch srma bundles/resources to 'output/bundles.yml' and 'output/resources.yml':

 ```bash
bundle exec ruby fetch_srma_items.rb
```

4. calculate resource identifier mapping to 'output/identifier_to_root_bundle_id.yml':

 ```bash
bundle exec ruby calculate_identifier_mapping.rb
```

5. calculate each account_id's follower_counts to 'output/account_follower_count.yml':
    
 ```bash
bundle exec ruby calculate_account_followers.rb
```


#### references

* trey_db_schema: references/trey_db_schema.sql

