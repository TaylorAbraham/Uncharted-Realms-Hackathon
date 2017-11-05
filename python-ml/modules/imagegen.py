import deviantart
import random
import re
import modules.config as config

# Connect API
da = deviantart.Api(config.client_id, config.client_secret)

# Provides a DeviantArt image URL related to a cardname
def generate_image_url(cardname):
    deviations = {'results': []}
    tag_ = ""
    # For each word in the cardname, try and find a relevant DeviantArt tag
    for word in reversed(re.findall(r"[\w']+", cardname)):
        tags = da.search_tags(word)
        if(tags != []):
            tag_ = random.choice(tags)
            break
    if(tag_ == ""):
        # No tag was found, so pick some random deviations
        while(deviations['results'] == []):
            deviations = da.browse(endpoint='popular')
    else:
        # Browse deviations of that tag
        deviations = da.browse(endpoint='tags', tag=tag_)
        if(deviations['results'] == []):
            # No tag was found, so pick some random deviations
            while(deviations['results'] == []):
                deviations = da.browse(endpoint='popular')


    # Select a random deviation
    deviation = random.choice(deviations['results'])
    while(deviation.preview == None):
        # No preview, therefore the deviation is a written story.
        # Repick a new deviation until an image deviation is picked.
        deviation = random.choice(deviations['results'])

    # Return image URL
    return deviation.preview['src']

