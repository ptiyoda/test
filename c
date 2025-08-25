import os
import requests
import json

# Variables (à définir dans GitLab CI/CD > Settings > Variables)
CONFLUENCE_BASE_URL = os.getenv("CONFLUENCE_BASE_URL")  # ex: https://company.atlassian.net/wiki
CONFLUENCE_USER = os.getenv("CONFLUENCE_USER")          # ton email Atlassian
CONFLUENCE_TOKEN = os.getenv("CONFLUENCE_TOKEN")        # token API Atlassian
PAGE_ID = os.getenv("CONFLUENCE_PAGE_ID")               # ID de la page à modifier

# Contenu à insérer
NEW_CONTENT = """
<h2>Mise à jour automatique 🚀</h2>
<p>Pipeline GitLab exécuté avec succès !</p>
"""

def get_page():
    url = f"{CONFLUENCE_BASE_URL}/rest/api/content/{PAGE_ID}?expand=body.storage,version"
    r = requests.get(url, auth=(CONFLUENCE_USER, CONFLUENCE_TOKEN))
    r.raise_for_status()
    return r.json()

def update_page():
    page = get_page()
    version = page["version"]["number"] + 1

    data = {
        "id": PAGE_ID,
        "type": "page",
        "title": page["title"],
        "space": {"key": page["space"]["key"]},
        "version": {"number": version},
        "body": {
            "storage": {
                "value": NEW_CONTENT,
                "representation": "storage"
            }
        }
    }

    url = f"{CONFLUENCE_BASE_URL}/rest/api/content/{PAGE_ID}"
    r = requests.put(url, auth=(CONFLUENCE_USER, CONFLUENCE_TOKEN),
                     headers={"Content-Type": "application/json"},
                     data=json.dumps(data))
    r.raise_for_status()
    print("✅ Page mise à jour avec succès.")

if __name__ == "__main__":
    update_page()
