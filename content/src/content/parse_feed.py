"""Parses RSS Feed"""
import yaml
import feedparser


with open("feeds.yaml", "r", encoding="utf-8") as feeds:
    urls = yaml.safe_load(feeds)

for url in urls:
    d = feedparser.parse(url)
    n_entries = len(d.entries)
    for entry in range(n_entries):
        content = d.entries[entry]["content"][0]
