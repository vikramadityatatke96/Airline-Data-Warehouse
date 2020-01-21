import pandas as pd
import feather
import numpy
path1 = 'C:\\Users\\vikra\\OneDrive - National College of Ireland\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\twitter_df2.feather'
tweets = feather.read_dataframe(path1)

tweets['Airline'] = pd.np.where(tweets.text.str.contains("austria", case = False), "Austrian Airlines",
                        pd.np.where(tweets.text.str.contains("etihad", case = False), "Etihad Airways",
                        pd.np.where(tweets.text.str.contains("klm", case = False), "KLM",
                        pd.np.where(tweets.text.str.contains("lufthansa", case = False), "Lufthansa",
                        pd.np.where(tweets.text.str.contains("qatar", case = False), "Qatar Airways",
                        pd.np.where(tweets.text.str.contains("singapore", case = False), "Singapore Airways",
                        pd.np.where(tweets.text.str.contains("flysaa", case = False), "South African Airways",
                        pd.np.where(tweets.text.str.contains("flysaa", case = False), "South African Airways",
                        pd.np.where(tweets.text.str.contains("turkish", case = False), "Turkish Airlines", "None")))))))))

path1 = 'C:\\Users\\vikra\\OneDrive - National College of Ireland\MSc Data Analytics\\Data Warehousing and Bussiness Intelligence\\Project\\twitter_df4.feather'
feather.write_dataframe(tweets,path1)