from flaskext.mysql import MySQL
from pymysql import cursors

db = MySQL(cursorclass=cursors.DictCursor) #specifies that data returned via cursor will be in dictionary form (python arrays/lists)
