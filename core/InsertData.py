# This Module has the Functions to Insert the Data in the MySQL Tables

# Importing Required Modules

import csv
import mysql.connector as con

# Functions


def InsertDataTrain():
    """
    InsertDataTrain() -> Inserts all the Train details in the train_info Table

    Parameters -> None
    """

    mn = con.connect(host="railwaytable.cqws3asie8ar.us-east-1.rds.amazonaws.com", user='svarshith7',
                                 password='Babesia1234', database="RailwayTable")

    cur = mn.cursor()

    # Iterating through all the values and insert's them in the table
    # Replace the path below with the absolute path of the file on your computer
    try:
        with open("/home/ec2-user/Train_details.csv") as csv_data:
            csv_reader = csv.reader(Train_details, delimiter=",")
            for row in csv_reader:
                cur.execute(
                    'INSERT INTO train_info VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)', row)
    except FileNotFoundError:
        print("Please check whether the file is in the Assets Folder or not and try changing the Location in InsertData.py")
    finally:
        mn.commit()  # Important: Committing the Changes
        cur.close()
        mn.close()
