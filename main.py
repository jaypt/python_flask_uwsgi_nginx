from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Brought to you by python2.7+flask+uwsgi+nginx"

if __name__ == "__main__":
   app.run(host='0.0.0.0', debug=True, port=80)
