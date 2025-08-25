import os
import requests
import json

# Variables d'environnement
CONFLUENCE_BASE_URL = os.getenv("CONFLUENCE_BASE_URL")
CONFLUENCE_USER = os.getenv("CONFLUENCE_USER")
CONFLUENCE_TOKEN = os.getenv("CONFLUENCE_TOKEN")
CONFLUENCE_PAGE_ID = os.getenv("CONFLUENCE_PAGE_ID")

def upload_json_attachment(filename, data):
    url = f"{CONFLUENCE_BASE_URL}/rest/api/content/{CONFLUENCE_PAGE_ID}/child/attachment"

    files = {
        'file': (filename, json.dumps(data, indent=2), 'application/json')
    }
    headers = {
        "X-Atlassian-Token": "no-check"  # nécessaire pour bypasser la protection CSRF
    }

    r = requests.post(url, auth=(CONFLUENCE_USER, CONFLUENCE_TOKEN), files=files, headers=headers)
    if r.status_code == 409:  # existe déjà → update
        print("🔄 Fichier déjà existant, mise à jour...")
        # récupérer l’ID de l’attachement
        attachments = requests.get(url, auth=(CONFLUENCE_USER, CONFLUENCE_TOKEN)).json()
        att_id = attachments["results"][0]["id"]
        update_url = f"{CONFLUENCE_BASE_URL}/rest/api/content/{CONFLUENCE_PAGE_ID}/child/attachment/{att_id}/data"
        r = requests.post(update_url, auth=(CONFLUENCE_USER, CONFLUENCE_TOKEN),
                          files=files, headers=headers)
    r.raise_for_status()
    print("✅ Fichier JSON attaché à la page Confluence.")

if __name__ == "__main__":
    # Exemple de données
    data = {
        "activeGates": [
            {"id": "AG-1", "version": "1.267", "osType": "LINUX"},
            {"id": "AG-2", "version": "1.268", "osType": "WINDOWS"}
        ]
    }
    upload_json_attachment("activegates.json", data)
