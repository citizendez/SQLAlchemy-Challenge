import numpy as np
import os.path
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
import pandas as pd
import json
from flask import Flask, jsonify

#BASE_DIR = os.path.dirname(os.path.abspath(__file__))
#db_path = BASE_DIR +  "\Resources\hawaii.sqlite"
#engine = create_engine(f"sqlite:///{db_path}")
engine = create_engine(f"sqlite:///Resources/hawaii.sqlite")
print(engine)
 

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

@app.route('/api/v1.0/precipitation')
def precipitation(): 
    sql = """
        SELECT date, prcp FROM Measurement limit 10 
        """ 
    #exicutes a sql query
    results = pd.read_sql(sql, engine)
    #new list
    lst = [ ]
    #loop to change key to date with value perciptitation
    for i, result in results.iterrows():
        dic = { }
        dic[result['date']] = result['prcp']
        lst.append(dic)
    #return new list of dictionarys
    return  jsonify(lst)

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

@app.route('/api/v1.0/<start>')
def start(start): 
    sql = f"""

SELECT min(temp), max(temp), avg(temp)
FROM station_measurements
WHERE date > '{start}';

    """
    #exicutes a sql query
    results = pd.read_sql(sql, engine)
    #converts reults to dictionary 
    results_json = results.to_dict(orient='records')
    #returns dict as json
    return  jsonify(results_json)

@app.route('/api/v1.0/<start>/<end>')
def start_end(start, end): 
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