# import json
# import requests
# headers = {
#     'API-KEY': 'e5c06d-d3426f',
# }
# r = requests.get('https://aviation-edge.com/v2/public/airplaneDatabase?', headers=headers)

import subprocess
import json
import pandas as pd
import feather

# proc = subprocess.run(["curl",  "-X", "GET",
#                   "https://aviation-edge.com/v2/public/planeTypeDatabase?key=e5c06d-d3426f&numberRegistration=1000"],
#                    stdout=subprocess.PIPE, encoding='utf-8')
#
# cadastro = proc.stdout
# planeTypeDatabase = pd.DataFrame([json.loads(cadastro)])
# print(planeTypeDatabase.to_string())
# pd.DataFrame.info(planeTypeDatabase)
# path = 'C:\\Users\\vikra\\OneDrive - National College of Ireland\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\IATA_df.feather'
# feather.write_dataframe(df, path)

get_aviationData = subprocess.run(["curl",  "-X", "GET",
                  "https://aviation-edge.com/v2/public/airlineDatabase?key=e5c06d-d3426f&codeIataAirline=SQ&codeIataAirline=AA&codeIataAirline=QR&codeIataAirline=LH&codeIataAirline=SA&codeIataAirline=EY&codeIataAirline=A3&codeIataAirline=OS&codeIataAirline=QS&codeIataAirline=KM&codeIataAirline=VS&codeIataAirline=KL&codeIataAirline=DY&codeIataAirline=TK&codeIataAirline=GA&codeIataAirline=UA&codeIataAirline=FR&limit=5000"],
                   stdout=subprocess.PIPE, encoding='utf-8')

aviationDataToJSON = get_aviationData.stdout
airlinesDatabase = pd.DataFrame([json.loads(aviationDataToJSON)])
print(airlinesDatabase.to_string())
pd.DataFrame.info(airlinesDatabase)

path = 'C:\\Users\\vikra\\OneDrive - National College of Ireland\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\airlinesDatabase.feather'
feather.write_dataframe(airlinesDatabase, path)

