This is after the DNS for (*.)rubyforge.org was [updated to point at Fastly on 8th May 2025](https://github.com/rubycentral/rubyforge-redirects/issues/8).

```
# Count of log entries
sqlite> select count(*) from logs;
185926

# Count of log entries grouped by HTTP status code and HTTP host
sqlite> select response_status, host, count(*) from logs group by 1, 2 order by count(*) desc limit 20;
404|rubyforge.org|33555
301|gems.rubyforge.org|17663
404|www.rubyforge.org|3835
404|sequel.rubyforge.org|2350
404|rack.rubyforge.org|2232
404|rake.rubyforge.org|2183
404|wxruby.rubyforge.org|2160
404|amazon.rubyforge.org|2135
404|god.rubyforge.org|2117
404|juggernaut.rubyforge.org|2117
404|webgen.rubyforge.org|2078
404|maruku.rubyforge.org|2044
404|mechanize.rubyforge.org|2040
404|rmagick.rubyforge.org|2038
404|kramdown.rubyforge.org|2031
404|backgroundrb.rubyforge.org|2024
404|wtr.rubyforge.org|2017
404|geokit.rubyforge.org|2013
404|libxml.rubyforge.org|2011
404|celerity.rubyforge.org|2008

# Count of log entries grouped by date
sqlite> select date(timestamp), count(*) from logs group by 1;
2025-04-04|254
2025-04-05|355
2025-04-06|300
2025-04-07|488
2025-04-08|350
2025-04-09|523
2025-04-10|957
2025-04-11|327
2025-04-12|488
2025-04-13|480
2025-04-14|776
2025-04-15|824
2025-04-16|653
2025-04-17|538
2025-04-18|297
2025-04-19|378
2025-04-20|674
2025-04-21|617
2025-04-22|340
2025-04-23|561
2025-04-24|565
2025-04-25|318
2025-04-26|576
2025-04-27|316
2025-04-28|522
2025-04-29|411
2025-04-30|346
2025-05-01|341
2025-05-02|522
2025-05-03|765
2025-05-04|512
2025-05-05|600
2025-05-06|344
2025-05-07|621
2025-05-08|10407
2025-05-09|158580

# Count of log entries grouped by host before switching DNS to Fastly
sqlite> select host, count(*) from logs where date(timestamp) < '2025-05-09' group by 1 order by count(*) desc limit 5;
gems.rubyforge.org|17607
rubyforge.org|3791
activewarehouse.rubyforge.org|428
www.rubyforge.org|248
juggernaut.rubyforge.org|155

# Count of log entries grouped by host after switching DNS to Fastly
sqlite> select host, count(*) from logs where date(timestamp) > '2025-05-08' group by 1 order by count(*) desc limit 5;
rubyforge.org|29769
www.rubyforge.org|3587
sequel.rubyforge.org|2287
rack.rubyforge.org|2212
rake.rubyforge.org|2124
```
