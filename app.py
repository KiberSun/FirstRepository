from flask import Flask, request
from flask_cors import CORS
app = Flask(__name__)
CORS(app)
@app.route('/')
def main():
    return 'API works!'
@app.route('/myroute')
def metric():
  args = request.args
  print(args)
  print(type(args))
  '''args = dict(args)
  print(type(args))'''
  return {'response':True, 'items': 'helloy world 2'}


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8000)