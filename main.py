# Author Tobias Rothmann, HackaTUM 2021
from typing import Optional, Set
from pydantic import BaseModel
from fastapi import FastAPI
import json
import pyodbc

app = FastAPI()


class MyBaseModel(BaseModel):
    def __hash__(self):  # make hashable BaseModel subclass
        return hash((type(self),) + tuple(self.__dict__.values()))


class Step(MyBaseModel):
    number: int
    text: str
    image_url: str


class Guide(BaseModel):
    id: int
    title: str
    image_url: str
    steps: Set[Step]


class Comment(MyBaseModel):
    name: str
    text: str
    date: str  # Date TODO


class Help(BaseModel):
    id: int
    title: str
    name: str
    text: str
    image_url: str
    date: str  # Date TODO
    comment: Set[Comment]


class Project(BaseModel):
    id: int
    title: str
    name: str
    text: str
    image_url: str
    date: str  # Date TODO
    steps: Set[Comment]


server = 'hackgardening.database.windows.net'
database = 'gardening'
username = 'admin-jo'
password = '{6xTVpHZDXkDL8k}'
driver = '{ODBC Driver 17 for SQL Server}'

with pyodbc.connect(
        'DRIVER=' + driver + ';SERVER=tcp:' + server + ';PORT=1433;DATABASE=' + database + ';UID=' + username + ';PWD=' + password) as conn:
    cursor = conn.cursor()
    # with cursor: cursor.execute(""" INSERT INTO Step( number, text, image_url, guide_id) VALUES (?,?,?,?) """, 7,
    # 'Begin harvesting your lettuce 30-45 days after planting. Harvest your lettuce in the morning, when your plants
    # most hydrated and at its strongest. Cut off the outer leaves. Do not harvest your lettuce plant all at once. As
    # long as you continue taking care of it, you can harvest it for several months. It takes about 2 weeks after
    # each harvesting to grow back.', 'NULL', 1)

if False:
    with conn.cursor() as cursor:
        cursor.execute("""CREATE TABLE Step (
                              number int,
                              text nchar(2000),
                              image_url nchar(1000),
                              guide_id int,
                              PRIMARY KEY (number, guide_id));""")
        cursor.execute("""CREATE TABLE Guide (
                              id int,
                              title nchar(100),
                              short_text nchar(2000),
                              image_url nchar(1000),
                              PRIMARY KEY (id)
                        );""")
        cursor.execute("""CREATE TABLE Help (
                              id int,
                              title nchar(100),
                              name nchar(100),
                              text nchar(2000),
                              image_url nchar(1000),
                              date smalldatetime,
                              PRIMARY KEY (id)
                    
                                );""")
        cursor.execute("""CREATE TABLE HelpComment (
                                  number int,
                                  help_id int,
                                  name nchar(100),
                                  date smalldatetime,
                                  text nchar(2000),
                                  PRIMARY KEY (number, help_id)

                                );""")
        cursor.execute("""CREATE TABLE Project (
                                  id int,
                                  title nchar(100),
                                  name nchar(100),
                                  text nchar(2000),
                                  image_url nchar(1000),
                                  date smalldatetime,
                                  PRIMARY KEY (id)

                                );""")
        cursor.execute("""CREATE TABLE ProjectComment (
                                  number int,
                                  project_id int,
                                  name nchar(100),
                                  date smalldatetime,
                                  text nchar(2000),
                                  PRIMARY KEY (number, project_id)

                                );""")


@app.get("/projects")
def read_projects():
    with cursor:
        cursor.execute("""
            SELECT * FROM Project
                               ;""")
        result = []
        row = cursor.fetchone()
        while row:
            selection = {'id': row[0], 'title': row[1], 'name': row[2], 'text': row[3], 'image': row[4],
                         'date': row[5]}
            result.append(selection)
            row = cursor.fetchone()
        return json.dumps(result)


@app.get("/project/{id}")
def read_project_by_id(id: int):
    with cursor:
        # project
        cursor.execute("""
            SELECT * FROM Project WHERE id=?
                               ;""", id)
        result = []
        row = cursor.fetchone()
        while row:
            selection = {'id': row[0], 'title': row[1], 'name': row[2], 'text': row[3], 'image': row[4],
                         'date': row[5]}
            result.append(selection)
            row = cursor.fetchone()
        # comments
        cursor.execute("""
                    SELECT * FROM ProjectComment WHERE project_id=?
                                       ;""", id)
        comments = []
        row = cursor.fetchone()
        while row:
            selection = {'number': row[0], 'name': row[2], 'date': row[3], 'text': row[4]}
            result.append(selection)
            row = cursor.fetchone()
        result.append(comments)
        return json.dumps(result)


@app.get("/articles")
def read_articles():
    with cursor:
        cursor.execute("""
            SELECT * FROM Guide
                               ;""")
        result = []
        row = cursor.fetchone()
        while row:
            selection = {'id': row[0], 'title': row[1], 'short_text': row[2], 'image': row[3]}
            result.append(selection)
            row = cursor.fetchone()
        return json.dumps(result)


@app.get("/article/{id}")
def read_articles_by_id(id: int):
    with cursor:
        # project
        cursor.execute("""
            SELECT * FROM Guide WHERE id=?
                               ;""", id)
        result = []
        row = cursor.fetchone()
        while row:
            selection = {'id': row[0], 'title': row[1], 'short_text': row[2], 'image': row[3]}
            result.append(selection)
            row = cursor.fetchone()
        # comments
        cursor.execute("""
                    SELECT * FROM Step WHERE guide_id=?
                                       ;""", id)
        comments = []
        row = cursor.fetchone()
        while row:
            selection = {'number': row[0], 'title': row[2], 'text': row[3], 'image': row[4]}
            result.append(selection)
            row = cursor.fetchone()
        result.append(comments)
        return json.dumps(result)


@app.get("/helplist")
def read_helplist():
    with cursor:
        cursor.execute("""
            SELECT * FROM Help
                               ;""")
        result = []
        row = cursor.fetchone()
        while row:
            selection = {'id': row[0], 'title': row[1], 'name': row[2], 'text': row[3], 'image': row[4],
                         'date': row[5]}
            result.append(selection)
            row = cursor.fetchone()
        return json.dumps(result)


@app.get("/help/{id}")
def read_helplist_by_id(id: int):
    with cursor:
        # project
        cursor.execute("""
            SELECT * FROM Help WHERE id=?
                               ;""", id)
        result = []
        row = cursor.fetchone()
        while row:
            selection = {'id': row[0], 'title': row[1], 'name': row[2], 'text': row[3], 'image': row[4],
                         'date': row[5]}
            result.append(selection)
            row = cursor.fetchone()
        # comments
        cursor.execute("""
                    SELECT * FROM HelpComment WHERE help_id=?
                                       ;""", id)
        comments = []
        row = cursor.fetchone()
        while row:
            selection = {'number': row[0], 'name': row[2], 'date': row[3], 'text': row[4]}
            result.append(selection)
            row = cursor.fetchone()
        result.append(comments)
        return json.dumps(result)


@app.post("/projects/")  # TODO projectS?
async def post_project(project: Project):
    with cursor:
        cursor.execute("""
            INSERT INTO Project (id, title, name, text, image, date) VALUES (?,?,?,?,?,?)
                               ;""", project.id, project.title, project.name, project.text, project.image_url,
                       project.date)
        return project


@app.post("/help/")
async def post_project(help: Help):
    with cursor:
        cursor.execute("""
            INSERT INTO Project (id, title, name, text, image, date) VALUES (?,?,?,?,?,?)
                               ;""", help.id, help.title, help.name, help.text, help.image_url, help.date)
        return help
