import socket
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return """
     <h1>Python Flask in Docker!</h1>
     <p>A simple Flask web app running inside a Docker container.</p> 
     """
if __name__ == '__main__':
    app.run(host= socket.gethostname(),port=5000)