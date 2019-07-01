import mysql.connector as mysql

class SQLer():
    def __init__(self,db="nature_forum"):
        self.conn = mysql.connect(
            host = "localhost",
            port = 3306,
            user = "root",
            password = "",
            database = db
        )
        self.cur = self.conn.cursor()
        
    def do(self,sql,fetch=True):
        try:
            self.cur.execute(sql)
            if fetch:
                ret = self.cur.fetchall()        
            else:
                ret = True
                self.conn.commit()
        except Exception as e:
            print("Error: %s"%(e))
            ret = False
        return ret
    
    def close(self):
        self.cur.close()
        self.conn.close()