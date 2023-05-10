import mysql.connector
import random
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="parking_management"
)
cursor = mydb.cursor()

for i in range(1, 101):

    random_num = random.randint(1, 100)

    cursor.execute(
        "UPDATE user_information SET parking_id = %s WHERE uid = %s", (random_num, i))
mydb.commit()
mydb.close()
