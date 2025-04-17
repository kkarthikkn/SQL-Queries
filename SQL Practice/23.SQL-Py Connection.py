import mysql.connector
from mysql.connector import Error

try:
    # Establish the connection
    connection = mysql.connector.connect(
        host='localhost',
        database='de_projects',
        user='root',
        password='********'    
    )

    if connection.is_connected():
        print("Connected to MySQL database")

        # Create a cursor object using the connection
        cursor = connection.cursor()

        # Define your query (for example, selecting all rows from a table)
        query = "SELECT * FROM emp"

        # Execute the query
        cursor.execute(query)

        # Fetch all rows from the executed query
        rows = cursor.fetchall()

        # Process the rows
        for row in rows:
            print(row)

except Error as e:
    print("Error while connecting to MySQL", e)

finally:
    # Close the cursor and connection
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")