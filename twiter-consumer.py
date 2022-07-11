import tweepy
from tweepy.tweet import Tweet


# create client object
client = tweepy.Client(
        bearer_token='AAAAAAAAAAAAAAAAAAAAACCFdwEAAAAAzL%2BGUwEMHk3po%2F4uu%2FDMPRu2GfU%3Dyy9lFkGTbyuZgydxhM01MbTVIvBDWkaPxQ7gtgNdRaALKhdlx2'
    )

user_id = '44196397'  # Elon Musk id

# retrieve first n=`max_results` tweets
tweets = client.get_users_tweets(
    id='44196397',
    max_results=100,
    exclude=['replies', 'retweets'],
    tweet_fields=['created_at', 'public_metrics', 'lang'])
# retrieve using pagination until no tweets left
tweets_list = list()
while True:
    if not tweets.data:
        break
    tweets_list.extend(tweets.data)
    if not tweets.meta.get('next_token'):
        break
    tweets = client.get_users_tweets(
        id=user_id,
        pagination_token=tweets.meta['next_token'],
        max_results=100,
        exclude=['replies', 'retweets']
    )
    break
    print(f'List {len(tweets_list)}')

for tw in tweets_list:
    tw: Tweet
    if 'bitcoin' in tw.text or 'Bitcoin' in tw.text or 'Dogecoin' in tw.text:
        print('#################### tweet')
        print('text', tw.text)
        print('created_at', tw.created_at)
        print('in_reply_to_user_id', tw.in_reply_to_user_id)
        print('organic_metrics', tw.organic_metrics)
        print('promoted_metrics', tw.promoted_metrics)
        print('public_metrics', tw.public_metrics)
        print('lang', tw.lang)
        print("#################### end")
