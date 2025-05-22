<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="csrf-token" content="{{ csrf_token() }}">

  <title>Tahun Akademik</title>
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="{{ asset('css/tahunakademik.css') }}" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
</head>
<style>
  .select2-container--default .select2-selection--single {
    padding: 12px 20px 10px 16px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 10px;
    background-color: #f2f2f2;
    color: #555;
    width: 100%;
    box-sizing: border-box;
    height: auto;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
    color: #555;
    line-height: 1.5;
    padding-left: 0;
    padding-right: 0;
    }

    .select2-container--default .select2-selection--single .select2-selection__arrow {
    height: 100%;
    top: 0;
    right: 16px;
    }

    .select2-container {
    width: 100% !important;
    }
</style>
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
            <a href="{{ route('akademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
              <img src="{{ asset('images/Group 1 (1).png') }}" alt="Dashboard" /> Dashboard
            </a>
          </li>
          <li class="active">
            <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik" /> Tahun Akademik
          </li>
          <li>
            <a href="{{ route('kelas') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
              <img src="{{ asset('images/Class.png') }}" alt="Kelas" /> Kelas
            </a>
          </li>
          <li>
            <a href="{{ route('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
              <img src="{{ asset('images/People.png') }}" alt="Mahasiswa" /> Mahasiswa
            </a>
          </li>
        </ul>
      </nav>
    </aside>


    <!-- Main Content -->
    <main class="main-content">
      <div class="breadcrumb-line-inline">
        <a href="{{ route('akademik') }}" class="grey-text">Dashboard</a> &gt; <strong>Tahun Akademik</strong>
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
              @foreach ($dataAll->pluck('status')->unique() as $status)
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
             
            </tr>
          </thead>
          <tbody>
            @foreach ($data as $tahunAk)
              <tr>
                <td>{{ $tahunAk->nama_thn_ak }}</td>
                <td>{{ $tahunAk->tgl_awal_kuliah }} - {{ $tahunAk->tgl_akhir_kuliah }}</td><td>
                  <button 
                    class="status-btn {{ strtolower($tahunAk->status_aktif) == 'aktif' ? 'active' : 'inactive' }}" 
                    onclick="toggleStatus(this, {{ $tahunAk->id_thn_ak }})">
                    {{ $tahunAk->status_aktif }}
                  </button>

                </td>
                
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

          <form id="form-thn-ak" action="{{ route('thnAk.create') }}" method="POST">
            @csrf
            <div class="form-group">
              <input type="text" name="id_thn_ak" placeholder="Kode Tahun Akademik *" />
            </div>

            <div class="form-group">
              <input type="text" name="nama_thn_ak" placeholder="Tahun Ajaran *" />
            </div>

            <div class="form-group filter-group">
              <select name="smt">
                <option value="">Pilih Semester *</option>
                <option value="Ganjil">Ganjil</option>
                <option value="Genap">Genap</option>
              </select>
            </div>

            <hr />

            <div class="date-group">
              <label>Start Date :</label>
              <div class="date-input">
                <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon" />
                <input type="date" name="tgl_awal_kuliah" />
              </div>
            </div>

            <div class="date-group">
              <label>End Date :</label>
              <div class="date-input">
                <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon" />
                <input type="date" name="tgl_akhir_kuliah" />
              </div>
            </div>

            <div class="form-group filter-group">
              <select name="status">
                <option value="">Pilih Status *</option>
                <option value="T">Tidak Aktif</option>
                <option value="Y">Aktif</option>
              </select>
            </div>

            <div class="button-group">
              <button type="submit" class="btn-simpan" id="btn-simpan-thn-ak">✔ Simpan</button>
              <button type="button" class="btn-cancel">✘ Batal</button>
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>

  <!-- Scripts -->
  <script src="{{ asset('js/popta.js') }}"></script>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="{{ asset('js/popta.js') }}"></script>
    <script>
        $(document).ready(function() {
            $('#status').select2({
                width: 'resolve'
            });
        });
        $(document).ready(function() {
            $('#tahun').select2({
                width: 'resolve'
            });
        });
    </script>

</body>
</html>
