##
#        File: moviefeedclass.py
#     Created: 11/10/2020
#     Updated: 11/15/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Movie feed web service
#     Version: 0.0.1 Python3
##

# Import modules
import moviefeedwebserviceclass # movie feed web service class
from flask import Flask, request, jsonify # Flask, request, jsonify
from flask_restful import Resource #Api # flask_restful, api, resource
import json # json

# Class
class MovieFeedClass(Resource):
  # Constructor
  def __init__(self):
    pass

  # Get method
  def get(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of movie feed web service class
    mfwsclass = moviefeedwebserviceclass.MovieFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      # Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = mfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = []

          # Check payload
          payloadResponse = mfwsclass._checkPayload(request.method, request.args, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Initialize list
              possibleParams = ['titlelong', 'titleshort', 'actionstatus', 'limit', 'sort']

              # Extract movie feed
              #resultDict = mfwsclass._extractMovieFeed('MariaDBSQLMovie', 'extracting', 'extractmediafeed', 'extractMovieFeed', possibleParams, payloadResponse['Result'])
              #resultDict = mfwsclass._extractMovieFeed('PGSQLMovie', 'extracting', 'extractmediafeed', 'extractMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._extractMovieFeed('MSSQLLMovie', 'extracting', 'dbo.extractMediaFeed', 'extractMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._extractMovieFeed('MSSQLWMovie', 'extracting', 'dbo.extractMediaFeed', 'extractMovieFeed', possibleParams, payloadResponse['Result'])

              # Check if there is data
              if resultDict:
                # Loop through sub elements
                for systemEntries in resultDict:
                  # Check if elements exists
                  if systemEntries.get('SError') == None:
                      # Store Message
                      returnDict = {'Status': 'Success', 'Message': 'Processed request', 'Count': len(resultDict), 'Result': resultDict}
                  else:
                    # Store Message
                    returnDict = {'Status': systemEntries['SError'], 'Message': systemEntries['SMessage'], 'Count': 0, 'Result': []}

                    # Set code
                    codeVal = 500

                    # Break out of loop
                    break
              else:
                # Store Message
                returnDict = {'Status': 'Success', 'Message': 'Processed request', 'Count': 0, 'Result': []}
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}

          # Store code
          codeVal = 400
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}

        # Store code
        codeVal = 400
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'GET not implemented properly', 'Count': 0, 'Result': []}

      # Log message
      mfwsclass._setLogger('GET ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal

  # Post method
  def post(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of movie feed web service class
    mfwsclass = moviefeedwebserviceclass.MovieFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      # Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = mfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = ['titlelong', 'titleshort', 'publishdate', 'actionstatus']

          # Check payload
          payloadResponse = mfwsclass._checkPayload(request.method, request.data, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Initailize list
              possibleParams = ['titlelong', 'titleshort', 'publishdate', 'actionstatus']

              # Insert movie feed
              #resultDict = mfwsclass._insertupdatedeleteMovieFeed('MariaDBSQLMovie', 'inserting', 'insertupdatedeletemediafeed', 'insertMovieFeed', possibleParams, payloadResponse['Result'])
              #resultDict = mfwsclass._insertupdatedeleteMovieFeed('PGSQLMovie', 'inserting', 'insertupdatedeletemediafeed', 'insertMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._insertupdatedeleteMovieFeed('MSSQLLMovie', 'inserting', 'dbo.insertupdatedeleteMediaFeed', 'insertMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._insertupdatedeleteMovieFeed('MSSQLWMovie', 'inserting', 'dbo.insertupdatedeleteMediaFeed', 'insertMovieFeed', possibleParams, payloadResponse['Result'])

              # Loop through sub elements
              for systemEntries in resultDict:
                # Check if elements exists
                if systemEntries.get('SError') == None:
                  # Store Message
                  returnDict = {'Status': 'Success', 'Message': 'Processed request', 'Count': len(resultDict), 'Result': resultDict}
                else:
                  # Store Message
                  returnDict = {'Status': systemEntries['SError'], 'Message': systemEntries['SMessage'], 'Count': 0, 'Result': []}

                  # Break out of loop
                  break
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'POST not implemented properly', 'Count': 0, 'Result': []}

      # Set code
      codeVal = 500

      # Log message
      mfwsclass._setLogger('POST ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal

  # Put method
  def put(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of movie feed web service class
    mfwsclass = moviefeedwebserviceclass.MovieFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      ## Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = mfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = ['titlelong', 'titleshort', 'publishdate', 'actionstatus']

          # Check payload
          payloadResponse = mfwsclass._checkPayload(request.method, request.data, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Initailize list
              possibleParams = ['titlelong', 'titleshort', 'publishdate', 'actionstatus']

              # Update movie feed
              #resultDict = mfwsclass._insertupdatedeleteMovieFeed('MariaDBSQLMovie', 'updating', 'insertupdatedeletemediafeed', 'updateMovieFeed', possibleParams, payloadResponse['Result'])
              #resultDict = mfwsclass._insertupdatedeleteMovieFeed('PGSQLMovie', 'updating', 'insertupdatedeletemediafeed', 'updateMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._insertupdatedeleteMovieFeed('MSSQLLMovie', 'updating', 'dbo.insertupdatedeleteMediaFeed', 'updateMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._insertupdatedeleteMovieFeed('MSSQLWMovie', 'updating', 'dbo.insertupdatedeleteMediaFeed', 'updateMovieFeed', possibleParams, payloadResponse['Result'])

              # Loop through sub elements
              for systemEntries in resultDict:
                # Check if elements exists
                if systemEntries.get('SError') == None:
                  # Store Message
                  returnDict = {'Status': 'Success', 'Message': 'Processed request', 'Count': len(resultDict), 'Result': resultDict}
                else:
                  # Store Message
                  returnDict = {'Status': systemEntries['SError'], 'Message': systemEntries['SMessage'], 'Count': 0, 'Result': []}

                  # Break out of loop
                  break
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'PUT not implemented properly', 'Count': 0, 'Result': []}

      # Set code
      codeVal = 500

      # Log message
      mfwsclass._setLogger('PUT ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal

  # Delete method
  def delete(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of movie feed web service class
    mfwsclass = moviefeedwebserviceclass.MovieFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      ## Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = mfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = ['titlelong']

          # Check payload
          payloadResponse = mfwsclass._checkPayload(request.method, request.data, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Initailize list
              possibleParams = ['titlelong']

              # Delete movie feed
              #resultDict = mfwsclass._insertupdatedeleteMovieFeed('MariaDBSQLMovie', 'deleting', 'insertupdatedeletemediafeed', 'deleteMovieFeed', possibleParams, payloadResponse['Result'])
              #resultDict = mfwsclass._insertupdatedeleteMovieFeed('PGSQLMovie', 'deleting', 'insertupdatedeletemediafeed', 'deleteMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._insertupdatedeleteMovieFeed('MSSQLLMovie', 'deleting', 'insertupdatedeletemediafeed', 'deleteMovieFeed', possibleParams, payloadResponse['Result'])
              resultDict = mfwsclass._insertupdatedeleteMovieFeed('MSSQLWMovie', 'deleting', 'dbo.insertupdatedeleteMediaFeed', 'deleteMovieFeed', possibleParams, payloadResponse['Result'])

              # Loop through sub elements
              for systemEntries in resultDict:
                # Check if elements exists
                if systemEntries.get('SError') == None:
                  # Store Message
                  returnDict = {'Status': 'Success', 'Message': 'Processed request', 'Count': len(resultDict), 'Result': resultDict}
                else:
                  # Store Message
                  returnDict = {'Status': systemEntries['SError'], 'Message': systemEntries['SMessage'], 'Count': 0, 'Result': []}

                  # Break out of loop
                  break
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'DELETE not implemented properly', 'Count': 0, 'Result': []}

      # Set code
      codeVal = 500

      # Log message
      mfwsclass._setLogger('DELETE ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal