```
# Download logs from S3 bucket
aws s3 sync s3://<log-bucket> /tmp/rubyforge-logs/

# Combine logs into a single file
cd /tmp
cat rubyforge-logs/*.log > rubyforge.org.log

# Each line contains JSON representing the log entry
$ tail -n1 rubyforge.org.log | json_pp 
{
   "fastly_is_edge" : true,
   "fastly_server" : "cache-bfi-kbfi7400031-BFI",
   "geo_city" : "the dalles",
   "geo_country" : "united states",
   "host" : "rubyforge.org",
   "request_method" : "GET",
   "request_protocol" : "HTTP/1.1",
   "request_referer" : "",
   "request_user_agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36",
   "response_body_size" : 826,
   "response_reason" : "Not Found",
   "response_state" : "MISS-CLUSTER",
   "response_status" : 404,
   "timestamp" : "2025-05-09T09:13:14+0000",
   "url" : "/pipermail/tzinfo-users/2012-November/000121.html"
}

# Convert JSON to CSV
cat rubyforge.org.log | \
ruby -rcsv -rjson -e "ARGF.each.with_index { |line, index| d = JSON.parse(line); puts d.keys.to_csv if index == 0; puts d.values.to_csv }" \
> rubyforge.org.log.csv

# Import into sqlite
sqlite3
.import rubyforge.org.log.csv logs --csv

# Remove trailing +0000 from timestamp strings so that sqlite can treat them as dates and times
sqlite> update logs set timestamp = replace(timestamp, '+0000', '');

# Count the records
sqlite> select count(*) from logs;
185926
```
