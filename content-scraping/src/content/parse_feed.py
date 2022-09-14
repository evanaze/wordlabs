"""Parses RSS Feed"""
import os
import logging

import yaml
import feedparser
import firebase_admin
from firebase_admin import firestore, credentials

LOGGER = logging.getLogger(__name__)
# create console handler and set level to debug
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
# create formatter
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# add formatter to ch
ch.setFormatter(formatter)

# add ch to logger
LOGGER.addHandler(ch)


class ContentScraper:
    
    def __init__(self):
        """Scrapes content."""
        self.db = None
        self.feeds = None

    def get_feeds(self):
        """Get the list of acceptable URLs from a YAML file."""
        with open("feed_urls.yaml", "r", encoding="utf-8") as feeds:
            self.feeds = yaml.safe_load(feeds)

    def authenticate_firebase(self):
        """Initialize the Firebase connection"""
        # Get the certificate file name
        cert_name = [file for file in os.listdir() if file.endswith(".json")
                     and file.startswith("wordlabs")][0]
        if not cert_name:
            LOGGER.error("Certificate file not found. Exiting.")
            exit(0)
        # Authenticate with the certificate
        cred = credentials.Certificate(cert_name)
        firebase_admin.initialize_app(cred)
        self.db = firestore.client()

    def write_content_html(self):
        """Write content to HTML files."""
        content = str(self.entry["content"][0]["value"]).encode("utf-8")
        filename = os.path.basename(self.entry["link"])
        filename += ".html" if filename.endswith("html") else filename
        with open(f"data/{filename}", "w", encoding="utf-8") as html_file:
            html_file.write(content)

    def write_content_firebase(self):
        """Write the article's content to Firebase DB."""
        # extract data from the article
        title = self.entry["author"]
        author = self.entry["title"]
        summary = self.entry["summary"]
        published = self.entry["published"]
        content = str(self.entry["content"][0]["value"])

        # Write to database
        ref = self.db.collection("scraped-articles").document(author)
        ref.set({
            "title": title,
            "summary": summary,
            "published": published,
            "content": content
        })

    def scrape_content(self):
        """Scrape content."""
        for url in self.feeds:
            LOGGER.info("Downloading %s", url)
            d = feedparser.parse(url)
            for self.entry in d.entries:
                self.write_content_firebase()

    def main(self):
        self.get_feeds()
        self.authenticate_firebase()
        self.scrape_content()


if __name__ == "__main__":
    ContentScraper().main()
