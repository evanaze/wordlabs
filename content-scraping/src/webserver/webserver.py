# Python 3 server example
from http.server import BaseHTTPRequestHandler, HTTPServer


HOSTNAME = "localhost"
PORT = 8080


class MyServer(BaseHTTPRequestHandler):
    def read_file(self):
        with open("data/test.html", "r", encoding="utf-8") as html_file:
            self.content = html_file.read()

    def do_GET(self):
        self.read_file()
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(bytes(self.content, "utf-8"))

if __name__ == "__main__":        
    webServer = HTTPServer((HOSTNAME, PORT), MyServer)
    print("Server started http://%s:%s" % (HOSTNAME, PORT))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")