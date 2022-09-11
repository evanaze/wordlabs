"""Parses RSS Feed"""
import os
from logging import getLogger

import yaml
import feedparser

LOGGER = getLogger(__name__)


class ContentScraper:
    
    def __init__(self):
        """Scrapes content."""
        self.urls = None
        self.content = None
        self.filename = None

    def get_urls(self):
        """Get the list of acceptable URLs from a YAML file."""
        with open("feeds.yaml", "r", encoding="utf-8") as feeds:
            self.urls = yaml.safe_load(feeds)

    def write_content_html(self):
        """Write content to HTML files."""
        with open(f"data/{self.filename}.html", "w", encoding="utf-8") as html_file:
            html_file.write(self.content)

    def scrape_content(self):
        """Scrape content."""
        for url in self.urls:
            LOGGER.info("Downloading %s", url)
            d = feedparser.parse(url)
            n_entries = len(d.entries)
            for entry in range(n_entries):
                self.filename = os.path.basename(d.entries[entry]["link"])
                self.content = str(d.entries[entry]["content"][0]["value"])
                self.write_content_html()

    def main(self):
        self.get_urls()
        self.scrape_content()


if __name__ == "__main__":
    ContentScraper().main()
