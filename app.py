import numpy as np
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
import pandas as pd
import json
from flask import Flask, jsonify

engine = create_engine(f"sqlite:///Resources/hawaii.sqlite")

app = Flask(__name__)

# index / home route
@app.route("/")
def home(): 
    routs = []
    routs.append('/api/v1.0/percipitation')
    routs.append('/api/v1.0/stations')
    routs.append('/api/v1.0/tobs')
    routs.append('/api/v1.0/&ltstart&gt')
    routs.append('/api/v1.0/&ltstart&gt/&ltend&gt')

    html = ' '
    html += f"<h1>Welcome to my Hawaii Weather API</h1>" 
    html += f"Available Routes:<br/>" 
    for rout in routs:
        html += f"<a target='_blank' href='http://127.0.0.1:5000/{rout}'>{rout}</a><br/>" 
    html += "<img src='https://images.fineartamerica.com/images-medium-large/hula-dancers-at-sunset-david-olsen.jpg'/>"
    return html


# additional routes

@app.route('/api/v1.0/percipitation')
def precipitation(): 
    sql = """
        SELECT date, prcp FROM Measurement 
        """ 
    #exicutes a sql query
    results = pd.read_sql(sql, engine)
    results.set_index('date', inplace=True)
    df = results.transpose()
    results_json = df.to_dict(orient='records')
    return jsonify(results_json)
    #new list
    #lst = [ ]
    #this loop runs through the rows but takes a long time to run
    # (loop to change key to date with value perciptitation)
    #for i, result in results.iterrows():
    #    dic = { }
    #    dic[result['date']] = result['prcp']
    #    lst.append(dic)
    #return new list of dictionarys
    #return  jsonify(lst)

@app.route('/api/v1.0/stations')
def stations(): 
    sql = """
        SELECT station FROM station
        """ 
    #exicutes a sql query
    results = pd.read_sql(sql, engine)
    #converts reults to dictionary 
    results_json = results.to_dict(orient='records')
    #returns dict as json
    return  jsonify(results_json)

@app.route('/api/v1.0/tobs')
def tobs(): 
    sql = """

    SELECT date, temp
    FROM station_measurements
    WHERE station = 
    (SELECT station FROM(
        SELECT count(station)as cnt, station
        FROM measurement
        GROUP BY station
        ORDER BY count(station) DESC LIMIT 1
    )
    )
    AND date > 
        (SELECT  DATE(MAX(date), '-1 year') 
        FROM Measurement) ;

    """
    #exicutes a sql query
    results = pd.read_sql(sql, engine)
    #converts reults to dictionary 
    results_json = results.to_dict(orient='records')
    #returns dict as json
    return  jsonify(results_json)

def is_date(date):
    isdate = True
    array = date.split('-')
    if len(array) != 3:
        isdate = False
    return isdate

@app.route('/api/v1.0/<start>')
def start(start):
    is_valid = is_date(start) 
    if is_valid == False: 
       return ('Invalid Date. Valid Dates format: 01-01-2017')   
    sql = f"""

SELECT min(temp), max(temp), avg(temp)
FROM station_measurements
WHERE date > '{start}';

    """
    print(sql)
    #exicutes a sql query
    results = pd.read_sql(sql, engine)
    #converts reults to dictionary 
    results_json = results.to_dict(orient='records')
    #returns dict as json
    return  jsonify(results_json)

@app.route('/api/v1.0/<start>/<end>')
def start_end(start, end): 
    if is_date(start) == False or is_date(end) == False: 
       return ('Invalid Date. Valid Dates format: 01-01-2017') 
    sql = f"""

SELECT min(temp), max(temp), avg(temp)
FROM station_measurements
WHERE date > '{start}' AND date < '{end}';

    """
    #exicutes a sql query
    results = pd.read_sql(sql, engine)
    #converts reults to dictionary 
    results_json = results.to_dict(orient='records')
    #returns dict as json
    return  jsonify(results_json)

if __name__ == '__main__':
    app.run(debug=True)