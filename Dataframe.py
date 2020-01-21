from pymongo import MongoClient
import pandas as pd
import feather
from _datetime import datetime
import re

client = MongoClient("mongodb://localhost")
twitterdb = client.twitterdb
cursor = twitterdb.twitter_search.find({"$text": {"$search": "austrian etihad klm lufthansa qatar singaporeair flysaa turkishairlines"}})
twitter_search = ["text", "created_at"]

twitter_df1 = pd.DataFrame(list(cursor), columns=twitter_search)
remove_ms = lambda x:re.sub("\+\d+\s","",x)
mk_dt = lambda x:datetime.strptime(remove_ms(x), "%a %b %d %H:%M:%S %Y")
my_form = lambda x:"{:%Y-%m-%d}".format(mk_dt(x))
twitter_df1.created_at = twitter_df1.created_at.apply(my_form)
twitter_df1['Airline'] = pd.np.where(twitter_df1.text.str.contains("austria", case = False), "Austrian Airlines",
                        pd.np.where(twitter_df1.text.str.contains("etihad", case = False), "Etihad Airways",
                        pd.np.where(twitter_df1.text.str.contains("klm", case = False), "KLM",
                        pd.np.where(twitter_df1.text.str.contains("lufthansa", case = False), "Lufthansa",
                        pd.np.where(twitter_df1.text.str.contains("qatar", case = False), "Qatar Airways",
                        pd.np.where(twitter_df1.text.str.contains("singapore", case = False), "Singapore Airways",
                        pd.np.where(twitter_df1.text.str.contains("flysaa", case = False), "South African Airways",
                        pd.np.where(twitter_df1.text.str.contains("flysaa", case = False), "South African Airways",
                        pd.np.where(twitter_df1.text.str.contains("turkish", case = False), "Turkish Airlines",
                        pd.np.where(twitter_df1.text.str.contains("boeing", case = False), "Boeing", "None"))))))))))

path = 'C:\\Users\\vikra\\OneDrive - National College of Ireland\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\twitter_df3.feather'
feather.write_dataframe(twitter_df1, path)
path1 = 'C:\\Users\\vikra\\OneDrive - National College of Ireland\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\twitter_df2.feather'

twitter_df1['Airline'] = pd.np.where(tweets.text.str.contains("austria", case = False), "Austrian Airlines",
                        pd.np.where(twitter_df1.text.str.contains("etihad", case = False), "Etihad Airways",
                        pd.np.where(twitter_df1.text.str.contains("klm", case = False), "KLM",
                        pd.np.where(twitter_df1.text.str.contains("lufthansa", case = False), "Lufthansa",
                        pd.np.where(twitter_df1.text.str.contains("qatar", case = False), "Qatar Airways",
                        pd.np.where(twitter_df1.text.str.contains("singapore", case = False), "Singapore Airways",
                        pd.np.where(twitter_df1.text.str.contains("flysaa", case = False), "South African Airways",
                        pd.np.where(twitter_df1.text.str.contains("flysaa", case = False), "South African Airways",
                        pd.np.where(twitter_df1.text.str.contains("turkish", case = False), "Turkish Airlines",
                        pd.np.where(twitter_df1.text.str.contains("boeing", case = False), "Boeing", "None"))))))))))