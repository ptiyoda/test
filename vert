<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>AdminLTE v4 — Vertical Tabs Example</title>

  <!-- Required CSS: Font Awesome (or other icons), AdminLTE (includes Bootstrap 5) -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="..." crossorigin="anonymous">
  <!-- Replace with your local AdminLTE v4 CSS if available -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@4.0.0/dist/css/adminlte.min.css">

  <style>
    /* Optional: tweak spacing/look for the example */
    .vertical-tabs-wrapper {
      display: flex;
      gap: 1rem;
      align-items: flex-start;
    }

    /* Constrain tab column width */
    .nav-column {
      min-width: 210px;
      max-width: 260px;
    }

    /* Make tabs horizontal on small screens */
    @media (max-width: 767.98px) {
      .vertical-tabs-wrapper { flex-direction: column; }
      .nav-column { width: 100%; max-width: none; }
    }

    /* Optional: make nav items full width and nicely spaced */
    .nav-pills .nav-link {
      display: flex;
      align-items: center;
      gap: .6rem;
      padding: .6rem .75rem;
      border-radius: .375rem;
    }

    /* Example: keep content card full width */
    .tab-content-card { flex: 1; }
  </style>
</head>
<body class="hold-transition sidebar-mini">
  <div class="wrapper p-3">

    <h4 class="mb-3">AdminLTE v4 — Vertical Tabs (Pills)</h4>

    <div class="card">
      <div class="card-body">
        <div class="vertical-tabs-wrapper">
          <!-- LEFT: vertical nav (pills) -->
          <div class="nav-column">
            <ul class="nav nav-pills flex-column" id="v-pills-tab" role="tablist" aria-orientation="vertical">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="tab-home" data-bs-toggle="pill" data-bs-target="#pane-home" type="button" role="tab" aria-controls="pane-home" aria-selected="true">
                  <i class="fa-solid fa-house"></i> Home
                </button>
              </li>

              <li class="nav-item" role="presentation">
                <button class="nav-link" id="tab-profile" data-bs-toggle="pill" data-bs-target="#pane-profile" type="button" role="tab" aria-controls="pane-profile" aria-selected="false">
                  <i class="fa-solid fa-user"></i> Profile
                </button>
              </li>

              <li class="nav-item" role="presentation">
                <button class="nav-link" id="tab-messages" data-bs-toggle="pill" data-bs-target="#pane-messages" type="button" role="tab" aria-controls="pane-messages" aria-selected="false">
                  <i class="fa-solid fa-envelope"></i> Messages
                </button>
              </li>

              <li class="nav-item mt-2" role="presentation">
                <button class="nav-link" id="tab-settings" data-bs-toggle="pill" data-bs-target="#pane-settings" type="button" role="tab" aria-controls="pane-settings" aria-selected="false">
                  <i class="fa-solid fa-gear"></i> Settings
                </button>
              </li>
            </ul>
          </div>

          <!-- RIGHT: tab content -->
          <div class="tab-content tab-content-card">
            <div class="tab-pane fade show active" id="pane-home" role="tabpanel" aria-labelledby="tab-home">
              <div class="card card-outline card-primary">
                <div class="card-header">
                  <h5 class="card-title mb-0">Home</h5>
                </div>
                <div class="card-body">
                  <p>Welcome to the Home pane. Use vertical tabs for navigation on wider screens.</p>
                </div>
              </div>
            </div>

            <div class="tab-pane fade" id="pane-profile" role="tabpanel" aria-labelledby="tab-profile">
              <div class="card card-outline card-success">
                <div class="card-header">
                  <h5 class="card-title mb-0">Profile</h5>
                </div>
                <div class="card-body">
                  <p>Profile content goes here.</p>
                </div>
              </div>
            </div>

            <div class="tab-pane fade" id="pane-messages" role="tabpanel" aria-labelledby="tab-messages">
              <div class="card card-outline card-warning">
                <div class="card-header">
                  <h5 class="card-title mb-0">Messages</h5>
                </div>
                <div class="card-body">
                  <p>Messages / inbox content.</p>
                </div>
              </div>
            </div>

            <div class="tab-pane fade" id="pane-settings" role="tabpanel" aria-labelledby="tab-settings">
              <div class="card card-outline card-info">
                <div class="card-header">
                  <h5 class="card-title mb-0">Settings</h5>
                </div>
                <div class="card-body">
                  <p>Various settings and controls.</p>
                </div>
              </div>
            </div>
          </div> <!-- /.tab-content -->

        </div> <!-- /.vertical-tabs-wrapper -->
      </div>
    </div>

  </div>

  <!-- Required JS: Bootstrap (included with AdminLTE) and AdminLTE JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Replace with your local AdminLTE JS if available -->
  <script src="https://cdn.jsdelivr.net/npm/admin-lte@4.0.0/dist/js/adminlte.min.js"></script>

  <script>
    // Optional: support linking directly to a tab via URL hash (e.g. #pane-messages)
    (function() {
      // Activate tab if URL hash matches a pane id
      function activateFromHash() {
        var id = window.location.hash;
        if (!id) return;
        var target = document.querySelector('[data-bs-target="' + id + '"]');
        if (target) {
          var tab = new bootstrap.Tab(target);
          tab.show();
          // scroll into view for smaller screens
          target.scrollIntoView({behavior: 'smooth', block: 'nearest'});
        }
      }

      // On load
      window.addEventListener('load', activateFromHash);
      // When hash changes (back/forward)
      window.addEventListener('hashchange', activateFromHash);

      // Update URL hash when user clicks a tab (so it can be bookmarked)
      document.querySelectorAll('[data-bs-toggle="pill"]').forEach(function(btn) {
        btn.addEventListener('shown.bs.tab', function (e) {
          var targetSelector = e.target.getAttribute('data-bs-target') || e.target.getAttribute('href');
          if (targetSelector) {
            history.replaceState(null, '', targetSelector);
          }
        });
      });
    })();
  </script>
</body>
</html>
