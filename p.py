from __future__ import annotations

import ipaddress

import json
from typing import Union


def est_cidr_dans_reseau(cidr_a_verifier: str, ip_reference: str, masque_reference: str) -> bool:
    try:
        # Convertir l'adresse CIDR en objet réseau
        reseau_verifier = ipaddress.ip_network(cidr_a_verifier, strict=False)

        # Convertir l'adresse de référence
        ip_ref = ipaddress.ip_address(ip_reference)

        # Convertir le masque de sous-réseau en objet réseau
        masque = ipaddress.ip_network(f"0.0.0.0/{masque_reference}", strict=False)

        # Calculer le réseau de référence en combinant l'adresse IP de référence avec le masque
        reseau_ref = ipaddress.ip_network(f"{ip_ref}/{masque.prefixlen}", strict=False)

        # Vérifier si le réseau CIDR à vérifier est dans le réseau de référence
        if reseau_verifier.subnet_of(reseau_ref):
            return True
        else:
            return False
    except ValueError as e:
        print(f"Erreur lors de la conversion : {e}")



def est_cidr_ipv4(cidr: str):
    try:
        # Tente de créer un objet réseau en notation CIDR
        reseau = ipaddress.ip_network(cidr, strict=False)
        return isinstance(reseau, ipaddress.IPv4Network)
    except ValueError:
        return False

def charger_ips(fichier: str) -> Union[bool | dict]:
    try:
        with open(fichier, 'r') as f:
            data = json.load(f)

            # Adresses IP à extraire
            ip_list = []

            # Parcourir les balises de service
            for service in data.get('values', []):
                # Vérifier les adresses IP pour chaque service
                for ip_prefix in service.get('properties', {}).get('addressPrefixes', []):
                    if est_cidr_ipv4(ip_prefix):
                        if est_cidr_dans_reseau(ip_prefix, ip_reference, masque_reference):
                            ip_list.append(ip_prefix)
            return ip_list

    except FileNotFoundError:
        print("Le fichier n'a pas été trouvé.")
        return []
    except json.JSONDecodeError:
        print("Erreur lors du décodage du fichier JSON.")
        return []


def main():
    # Chemin vers le fichier JSON téléchargé
    fichier_ips = 'ServiceTags_Public_20241021.json'  # Modifiez ce chemin avec le chemin réel du fichier téléchargé
    ips = charger_ips(fichier_ips)

    # Afficher les adresses IP chargées
    print("Adresses IP chargées :")
    for ip in ips:
        print(ip)

if __name__ == "__main__":
    main()
