"""Parses RSS Feed"""
import os

import yaml
import feedparser


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
        with open(f"data/{self.filename}", "w", "utf-8") as html_file:
            html_file.write(self.content)

    def scrape_content(self):
        """Scrape content."""
        for url in self.urls:
            d = feedparser.parse(url)
            n_entries = len(d.entries)
            for entry in range(n_entries):
                self.filename = os.path.basedir(d.entries[entry]["link"])
                self.content = d.entries[entry]["content"][0]
                self.write_content_html()

    def main(self):
        self.get_urls()
        self.scrape_content()


if __name__ == "__main__":
    ContentScraper().main()
