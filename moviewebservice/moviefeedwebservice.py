##
#        File: moviefeedwebservice.py
#     Created: 11/10/2020
#     Updated: 11/18/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Movie feed web service
#     Version: 0.0.1 Python3
##

# Import modules
from flask import Flask, request, jsonify # Flask, request, jsonify
from flask_restful import Api # flask_restful, api
import json # json
import moviefeedwebserviceclass # movie feed web service class
from moviefeedclass import MovieFeedClass # movie feed web service class
from moviefeedtitleshortclass import MovieFeedTitleShortClass # movie feed title short web service class
from moviefeedtitleshortactionstatusclass import MovieFeedTitleShortActionStatusClass # movie feed title short action status web service class

# Create objects
app = Flask(__name__)
api = Api(app)

# Set object
mfwsclass = moviefeedwebserviceclass.MovieFeedWebServiceClass()

# try to execute the command(s)
try:
  # Error handler
  @app.errorhandler(Exception)
  def errorHandling(eh):
    # Initialize variables
    messageVal = ''
    codeVal = 500

    # try to execute the command(s)
    try:
      # Set message
      messageVal = str(eh.code) + ' ' + str(eh.name) + ' ' + str(eh.description)

      # Set code
      codeVal = eh.code
    # Catch exceptions
    except Exception as e:
      # Set message
      messageVal = 'ErrorHandler'

      # Log message
      mfwsclass._setLogger('ErrorHandler ' + str(e))

    # Return message
    return {'Status': 'Error', 'Message': messageVal, 'Count': 0, 'Result': []}, codeVal

  # Store possible methods
  validMethods = ['GET', 'POST', 'PUT', 'DELETE']

  # Before request
  @app.before_request
  def before_request_func():
    # Check if request method is in the list
    if request.method not in validMethods:
      # Return message
      return {'Status': 'Error', 'Message': 'Method invalid or not implemented', 'Count': 0, 'Result': []}, 501

  # Add resource for api web service call movie feed
  api.add_resource(MovieFeedClass, '/api/moviefeed', methods = validMethods)

  # Add resource for additional api web service call movie feed title short
  api.add_resource(MovieFeedTitleShortClass, '/api/moviefeed/titleshort', methods = ['PUT', 'DELETE'])

  # Add resource for additional api web service call movie feed title short action status
  api.add_resource(MovieFeedTitleShortActionStatusClass, '/api/moviefeed/titleshortactionstatus', methods = ['PUT'])
# Catch exceptions
except Exception as e:
  # Log message
  mfwsclass._setLogger('Issue executing main PY file ' + str(e))

# Run program
if __name__ == '__main__':
  # Run app
  app.run(host='127.0.0.1', port=4817, debug=True, threaded=True)