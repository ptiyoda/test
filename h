{% load static %}

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Liste des serveurs</title>
    <!-- AdminLTE & Bootstrap -->
    <link rel="stylesheet" href="{% static 'adminlte/plugins/fontawesome-free/css/all.min.css' %}">
    <link rel="stylesheet" href="{% static 'adminlte/dist/css/adminlte.min.css' %}">
    <!-- Select2 -->
    <link rel="stylesheet" href="{% static 'adminlte/plugins/select2/css/select2.min.css' %}">
</head>
<body class="hold-transition sidebar-mini">

<div class="wrapper">
  <div class="content-wrapper p-4">

    <h1 class="mb-3">Serveurs</h1>

    <!-- Filtres -->
    <form method="get" class="card card-body mb-4">
      <div class="row">
        
        <div class="col-md-3">
          <label>Datacenter</label>
          <select class="form-control select2" name="datacenter" onchange="this.form.submit()">
            <option value="">-- Tous --</option>
            {% for dc in datacenters %}
              <option value="{{ dc.id }}" {% if request.GET.datacenter == dc.id|stringformat:"s" %}selected{% endif %}>
                {{ dc.nom }}
              </option>
            {% endfor %}
          </select>
        </div>

        <div class="col-md-3">
          <label>Localisation</label>
          <select class="form-control select2" name="localisation" onchange="this.form.submit()">
            <option value="">-- Toutes --</option>
            {% for loc in localisations %}
              <option value="{{ loc }}" {% if request.GET.localisation == loc %}selected{% endif %}>
                {{ loc }}
              </option>
            {% endfor %}
          </select>
        </div>

        <div class="col-md-3">
          <label>Pays</label>
          <select class="form-control select2" name="pays" onchange="this.form.submit()">
            <option value="">-- Tous --</option>
            {% for p in pays %}
              <option value="{{ p.id }}" {% if request.GET.pays == p.id|stringformat:"s" %}selected{% endif %}>
                {{ p.nom }}
              </option>
            {% endfor %}
          </select>
        </div>

        <div class="col-md-3">
          <label>IP</label>
          <input type="text" class="form-control" name="ip" placeholder="Ex: 192.168.0.1"
                 value="{{ request.GET.ip }}" onchange="this.form.submit()">
        </div>

      </div>
    </form>

    <!-- Résultats -->
    <div class="card">
      <div class="card-body p-0">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>IP</th>
              <th>Datacenter</th>
              <th>Localisation</th>
              <th>Pays</th>
            </tr>
          </thead>
          <tbody>
            {% for serveur in serveurs %}
              <tr>
                <td>{{ serveur.ip }}</td>
                <td>{{ serveur.datacenter.nom }}</td>
                <td>{{ serveur.datacenter.localisation }}</td>
                <td>{{ serveur.datacenter.pays.nom }}</td>
              </tr>
            {% empty %}
              <tr><td colspan="4">Aucun serveur trouvé.</td></tr>
            {% endfor %}
          </tbody>
        </table>
      </div>
    </div>

    <!-- Pagination -->
    {% if is_paginated %}
      <nav>
        <ul class="pagination">
          {% if page_obj.has_previous %}
            <li class="page-item">
              <a class="page-link" href="?page={{ page_obj.previous_page_number }}{% for key,value in request.GET.items %}{% if key != 'page' %}&{{ key }}={{ value }}{% endif %}{% endfor %}">Précédent</a>
            </li>
          {% endif %}

          <li class="page-item active">
            <span class="page-link">Page {{ page_obj.number }} / {{ page_obj.paginator.num_pages }}</span>
          </li>

          {% if page_obj.has_next %}
            <li class="page-item">
              <a class="page-link" href="?page={{ page_obj.next_page_number }}{% for key,value in request.GET.items %}{% if key != 'page' %}&{{ key }}={{ value }}{% endif %}{% endfor %}">Suivant</a>
            </li>
          {% endif %}
        </ul>
      </nav>
    {% endif %}

  </div>
</div>

<!-- JS AdminLTE -->
<script src="{% static 'adminlte/plugins/jquery/jquery.min.js' %}"></script>
<script src="{% static 'adminlte/plugins/bootstrap/js/bootstrap.bundle.min.js' %}"></script>
<script src="{% static 'adminlte/dist/js/adminlte.min.js' %}"></script>
<!-- Select2 -->
<script src="{% static 'adminlte/plugins/select2/js/select2.full.min.js' %}"></script>
<script>
  $(function () {
    $('.select2').select2();
  });
</script>

</body>
</html>
