import re

def parse_haproxy_config(file_path):
    with open(file_path, 'r') as file:
        config_data = file.read()

    # Regex pour extraire les sections frontend et backend
    frontend_pattern = re.compile(r"frontend\s+(\S+)\s+(.*?)\n(?:(?:\s{4}|\t)(.*?))*\s+backend", re.DOTALL)
    backend_pattern = re.compile(r"backend\s+(\S+)\s+(.*?)\n(?:(?:\s{4}|\t)(.*?))*\s*\n", re.DOTALL)

    frontends = frontend_pattern.findall(config_data)
    backends = backend_pattern.findall(config_data)

    # Traitement des résultats
    frontend_data = []
    for frontend in frontends:
        name, bind_line, details = frontend
        frontend_data.append({
            'name': name,
            'bind': bind_line.strip(),
            'details': details.strip().splitlines()
        })
    
    backend_data = []
    for backend in backends:
        name, balance_line, details = backend
        backend_data.append({
            'name': name,
            'balance': balance_line.strip(),
            'servers': [line.strip() for line in details.splitlines() if line.strip().startswith('server')]
        })

    return frontend_data, backend_data

# Exemple d'utilisation
file_path = 'haproxy.cfg'  # Remplace par le chemin de ton fichier
frontends, backends = parse_haproxy_config(file_path)

# Affichage des données parsées
print("Frontends:")
for frontend in frontends:
    print(frontend)

print("\nBackends:")
for backend in backends:
    print(backend)
