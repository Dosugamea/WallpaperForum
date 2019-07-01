from SQLer import SQLer
import random

conn = SQLer()

'''
INSERT

for i in range(1,20):
    conn.do("INSERT INTO creations (`Title`, `Info`, `Artist`, `View`) VALUES ('幼女%s', '幼女。', '幼女%s', '%s')"%(i,random.randint(1,5),random.randint(1,20)),fetch=False)
print("OK")
'''

datas = conn.do("SELECT * from creations ORDER BY ID ASC LIMIT 10 offset %s"%(0*10))
print(datas)