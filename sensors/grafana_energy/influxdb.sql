DROP DATABASE home_assistant
CREATE DATABASE home_assistant
/*
DROP MEASUREMENT power
DROPdrop MEASUREMENT power_h
DROP MEASUREMENT power_d
DROP CONTINUOUS QUERY "cq_power" ON "home_assistant"
DROP CONTINUOUS QUERY "cq_power_1h" ON "home_assistant"
DROP CONTINUOUS QUERY "cq_power_1d" ON "home_assistant"
*/
ALTER  RETENTION POLICY "autogen" ON "home_assistant" DURATION 8w REPLICATION 1 DEFAULT
CREATE RETENTION POLICY "raw_data" ON "home_assistant" DURATION 53w REPLICATION 1
CREATE RETENTION POLICY "storage" ON "home_assistant" DURATION 104w REPLICATION 1
CREATE CONTINUOUS QUERY "cq_power" ON "home_assistant" BEGIN SELECT last("friendly_name") as "friendly_name", mean("power") as "power",mean("amp") as "amp",mean("volt") as "volt", last("kwh_price") as "kwh_price", last("daily_price") as "daily_price", (round(((sum("power") / 1000) * (30  / 3600))*10000)/10000) as "kwh", round(((round(((sum("power") / 1000) * (30  / 3600))*10000)/10000) * last("kwh_price"))*10000)/10000 as "price" INTO "raw_data"."power" FROM ( SELECT  mean("power") as "power", mean("amp") as "amp", mean("volt") as "volt", last("device") as "device",  last("friendly_name_str") as "friendly_name", last("kwh_price") as "kwh_price", last("daily_price") as "daily_price" FROM /sensor.energy_.*_usage/ GROUP BY time(30s), * fill(null)) GROUP BY time(30s), * END
CREATE CONTINUOUS QUERY "cq_power_1h" ON "home_assistant" RESAMPLE EVERY 1m BEGIN SELECT round(sum("kwh")*10000)/10000 as "kwh", round(sum("price")*10000)/10000 as "price",  max("amp") as "amp_max", min("amp") as "amp_min", mean("amp") as "amp_mean", last("friendly_name") as "friendly_name", sum("power") as "power", max("power") as "power_max", min("power") as "power_min", mean("power") as "power_mean", max("volt") as "volt_max", min("volt") as "volt_min", mean("volt") as "volt_mean", last("kwh_price") as "kwh_price", last("daily_price") as "daily_price"  INTO "storage"."power_h" FROM "raw_data".power GROUP BY time(1h), * END
CREATE CONTINUOUS QUERY "cq_power_1d" ON "home_assistant" RESAMPLE EVERY 1m BEGIN SELECT round(sum("kwh")*10000)/10000 as "kwh", round(sum("price")*10000)/10000 as "price", max("amp") as "amp_max", min("amp") as "amp_min", mean("amp") as "amp_mean", last("friendly_name") as "friendly_name", sum("power") as "power", max("power") as "power_max", min("power") as "power_min", mean("power") as "power_mean", max("volt") as "volt_max", min("volt") as "volt_min", mean("volt") as "volt_mean", last("kwh_price") as "kwh_price", last("daily_price") as "daily_price"  INTO "storage"."power_d" FROM "raw_data".power GROUP BY time(1d), * tz('Europe/Lisbon') END
