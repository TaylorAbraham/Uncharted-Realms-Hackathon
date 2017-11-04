import requests
import random
from bs4 import BeautifulSoup

def generate_names():
    page = requests.get("http://www.seventhsanctum.com/generate.php?Genname=monstername")
    soup = BeautifulSoup(page.content, 'html.parser')
    html_elements = soup.find_all(class_='GeneratorResultPrimeBG')
    results = []
    for element in html_elements:
        results.append(element.text)
    return results

