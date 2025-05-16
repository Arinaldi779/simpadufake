<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Tahun Akademik</title>
  <link rel="stylesheet" href="{{ asset('css/tahunakademik.css') }}" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
</head>
<body>

  <!-- Header -->
  <header class="main-header">
    <div class="left-header">
      <img src="{{ asset('images/logo poliban.png') }}" alt="Logo" class="logo-icon" />
      <span class="app-title">SIMPADU</span>
    </div>
    <div class="right-header">
      <img src="{{ asset('images/Bell.png') }}" alt="Bell" class="bell-icon" />
      <img src="{{ asset('images/Test Account.png') }}" alt="Account" class="logo-icon" />
    </div>
  </header>

  <!-- Sidebar Toggle -->
  <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

  <div class="container">

    <!-- Sidebar -->
    <aside class="sidebar">
      <div class="sidebar-header">
        <img src="{{ asset('images/Graduation Cap (1).png') }}" alt="Graduation Cap" class="logo-icon" />
        <h2>Akademik</h2>
      </div>
      <hr class="divider" />
      <nav>
        <ul>
          <li>
            <a href="{{ url('/') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
              <img src="{{ asset('images/Group 1 (1).png') }}" alt="Dashboard" /> Dashboard
            </a>
          </li>
          <li class="active">
            <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik" /> Tahun Akademik
          </li>
          <li>
            <a href="{{ url('kelas') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
              <img src="{{ asset('images/Class.png') }}" alt="Kelas" /> Kelas
            </a>
          </li>
          <li>
            <a href="{{ url('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
              <img src="{{ asset('images/People.png') }}" alt="Mahasiswa" /> Mahasiswa
            </a>
          </li>
        </ul>
      </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="breadcrumb-line-inline">
        <a href="{{ url('/') }}" class="grey-text">Dashboard</a> &gt; <strong>Tahun Akademik</strong>
      </div>

      <br />
      <div class="header-flex">
        <h2 class="page-title">Tahun Akademik</h2>
        <button class="add-button">+ Tambah Tahun Akademik</button>
      </div>

      <!-- Filter -->
      <form method="GET" action="{{ route('tahunakademik') }}">
        <div class="filter-box">
          <div class="filter-group">
            <label for="tahun">Tahun</label>
            <select id="tahun" name="tahun">
              <option value="">Semua Tahun</option>
              @foreach ($dataAll as $tahunAk)
                <option value="{{ $tahunAk->nama_thn_ak }}" {{ request('tahun') == $tahunAk->nama_thn_ak ? 'selected' : '' }}>
                  {{ $tahunAk->nama_thn_ak }}
                </option>
              @endforeach
            </select>
          </div>

          <div class="filter-group">
            <label for="status">Status</label>
            <select id="status" name="status">
              <option value="">Semua Status</option>
              @foreach ($dataAll->pluck('aktif')->unique() as $status)
                <option value="{{ $status }}" {{ request('status') == $status ? 'selected' : '' }}>
                  {{ $status === 'Y' ? 'Aktif' : 'Tidak Aktif' }}
                </option>
              @endforeach
            </select>
          </div>

          <button type="submit" class="btn-filter">Filter</button>

        </div>
      </form>

      <!-- Table -->
      <div class="table-container">
        <table class="academic-table">
          <thead>
            <tr>
              <th>TAHUN AKADEMIK</th>
              <th>TANGGAL MULAI – SELESAI</th>
              <th>STATUS</th>
              <th>AKSI</th>
            </tr>
          </thead>
          <tbody>
            @foreach ($data as $tahunAk)
              <tr>
                <td>{{ $tahunAk->nama_thn_ak }}</td>
                <td>{{ $tahunAk->tgl_awal_kuliah }} - {{ $tahunAk->tgl_akhir_kuliah }}</td>
                <td><span class="status active">{{ $tahunAk->status_aktif }}</span></td>
                <td><a href="{{ route('editta',$tahunAk->id_thn_ak) }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>

              </tr>
            @endforeach
          </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
          <div class="page-buttons">
            {{ $data->links('components.pagination-custom') }}
          </div>
        </div>
      </div>

      <!-- Modal Tambah Tahun Akademik -->
      <div class="popup-overlay" id="popup">
        <div class="popup-content">
          <h2>Tambah Tahun Akademik</h2>

          <form action="{{ route('thnAk.create') }}" method="POST">
            @csrf
          <div class="form-group">
            <input type="text" name="id_thn_ak" placeholder="Kode Tahun Akademik *" />
          </div>

          <div class="form-group">
            <input type="text" name="nama_thn_ak" placeholder="Tahun Ajaran *" />
          </div>

          <div class="form-group filter-group">
            <input type="text" name="catatan" placeholder="Catatan *" />
          </div>

          <hr />

          <div class="date-group">
            <label>Start Date :</label>
            <div class="date-input">
              <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon" />
              <input type="date" name="tgl_awal_kuliah"/>
            </div>
          </div>

          <div class="date-group">
            <label>End Date :</label>
            <div class="date-input">
              <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon" />
              <input type="date" name="tgl_akhir_kuliah"/>
            </div>
          </div>

          <div class="form-group filter-group">
            <select name="aktif">
              <option value="T">Tidak Aktif *</option>
              <option value="Y">Aktif</option>
            </select>
          </div>

          <div class="button-group">
            <button class="btn-simpan">✔ Simpan</button>
            <button class="btn-cancel">✘ Batal</button>
          </div>
        </div>
      </div>
    </main>
  </div>

  <!-- Notification -->
  <div id="notification" class="notification">Berhasil Menambahkan Data</div>

  <!-- Scripts -->
  <script src="{{ asset('js/popta.js') }}"></script>

</body>
</html>
