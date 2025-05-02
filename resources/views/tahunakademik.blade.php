<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tahun Akademik</title>
    <link rel="stylesheet" href="{{ asset('css/tahunakademik.css') }}">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header class="main-header">
        <div class="left-header">
            <img src="{{ asset('images/logo poliban.png') }}" alt="Logo" class="logo-icon">
            <span class="app-title">SIMPADU</span>
        </div>
        <div class="right-header">
            <img src="{{ asset('images/Bell.png') }}" alt="Bell" class="bell-icon">
            <img src="{{ asset('images/Test Account.png') }}" alt="Account" class="logo-icon">
        </div>
    </header>

    <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

    <div class="container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <img src="{{ asset('images/Graduation Cap (1).png') }}" alt="Graduation Cap" class="logo-icon">
                <h2>Akademik</h2>
            </div>
            <hr class="divider">
            <nav>
                <ul>
                <li>
                    <a href="{{ url('akademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                        <img src="{{ asset('images/Group 1 (1).png') }}" alt="Dashboard"> Dashboard
                    </a>
                </li>
                    <li class="active">
                    <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik"> Tahun Akademik
                    </li>
                    <li>
                    <a href="{{ url('kelas') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                    <img src="{{ asset('images/Class.png') }}" alt="Kelas"> Kelas
                    </a>
                    </li>
                    <li>
                    <a href="{{ url('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                        <img src="{{ asset('images/People.png') }}" alt="Mahasiswa"> Mahasiswa
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
        <div class="breadcrumb-line-inline">
            <a href="{{ url('akademik') }}" class="grey-text">Dashboard</a> &gt; <strong>Mahasiswa</strong>
        </div>


            <br>
            <div class="header-flex">
                <h2 class="page-title">Tahun Akademik</h2>
                <button class="add-button">+ Tambah Tahun Akademik</button>
            </div>
            {{-- Filter Status --}}
            <form method="GET" action="{{ route('tahunakademik') }}">
              <div class="filter-box">
                <div class="filter-group">
                  <label for="tahun">Tahun</label>
                  <select id="tahun" name="tahun">
                    <option value="">Semua Tahun</option>
                    @foreach ($data as $tahunAk)
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
                    @foreach ($data->pluck('aktif')->unique() as $status)
                      <option value="{{ $status }}" {{ request('status') == $status ? 'selected' : '' }}>
                        {{ $status === 'Y' ? 'Aktif' : 'Tidak Aktif' }}
                      </option>
                    @endforeach
                  </select>
                </div>
            
                <button type="submit">Filter</button>
              </div>
            </form>
            
            <div class="table-container">
              <table class="academic-table">
                <thead>
                  <tr>
                    <th>TAHUN AKADEMIK</th>
                    <th>SEMESTER</th>
                    <th>TANGGAL MULAI – SELESAI</th>
                    <th>STATUS</th>
                    <th>AKSI</th>
                  </tr>
                </thead>
                {{-- Pemanggilan Data --}}
                @foreach ($data as $tahunAk)
                {{-- @dd($tahunAk) --}}
                    <tbody>
                        <tr>
                            <td>{{ $tahunAk->nama_thn_ak }}</td>
                            <td>Ganjil</td>
                            <td>{{ $tahunAk->tgl_awal_kuliah }} - {{ $tahunAk->tgl_akhir_kuliah }}</td>
                            {{-- <td>{{ $tahunAk->tgl_awal_only }} - {{ $tahunAk->tgl_akhir_only }}</td> --}}
                            <td><span class="status active">{{ $tahunAk->status_aktif }}</span></td>
                            <td><button class="edit-btn">Edit</button></td>
                        </tr>
                    </tbody>
                    @endforeach
                </table>
                <div class="pagination">
                    <span>Showing 1 to 10 of 20 results</span>
                    <div class="page-buttons">
                        {{-- <button>&lt;</button>
                        <button class="current">1</button>
                        <button class="current">2</button>
                        <button class="current">3</button> 
                        <button>&gt;</button> --}}
                        {{-- Pagination --}}
                        {{ $data->links('pagination::bootstrap-5') }}
                    </div>
                </div>
            </div>

            <div class="popup-overlay" id="popup">
    <div class="popup-content">
      <h2>Tambah Tahun Akademik</h2>

      <div class="form-group">
        <input type="text" placeholder="Tahun Ajaran *">
      </div>

      <div class="form-group filter-group">
        <select id="semester">
          <option>Semester *</option>
          <option>Ganjil</option>
          <option>Genap</option>
        </select>
      </div>

      <hr>

      <div class="date-group">
        <label>Start Date :</label>
        <div class="date-input">
          <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon">
          <input type="date">
        </div>
      </div>

      <div class="date-group">
        <label>End Date :</label>
        <div class="date-input">
          <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon">
          <input type="date">
        </div>
      </div>

      <div class="form-group filter-group">
        <select>
          <option>Tidak Aktif *</option>
          <option>Aktif</option>
        </select>
      </div>

      <div class="button-group">
        <button class="btn-simpan">✔ Simpan</button>
        <button class="btn-cancel">✘ Simpan</button>
      </div>
    </div>
  </div>

  <div class="popup-overlay" id="popupedit">
  <div class="popup-content">
    <h2>Edit Tahun Akademik</h2>

    <div class="form-group">
      <input type="text" placeholder="Tahun Ajaran *">
    </div>

    <div class="form-group filter-group">
      <select id="semester">
        <option>Semester *</option>
        <option>Ganjil</option>
        <option>Genap</option>
      </select>
    </div>

    <hr>

    <div class="date-group">
      <label>Start Date :</label>
      <div class="date-input">
        <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon">
        <input type="date">
      </div>
    </div>

    <div class="date-group">
      <label>End Date :</label>
      <div class="date-input">
        <img src="{{ asset('images/calendar.png') }}" alt="Calendar Icon">
        <input type="date">
      </div>
    </div>

    <div class="form-group filter-group">
      <select>
        <option>Status *</option>
        <option>Aktif</option>
        <option>Tidak Aktif</option>
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
    <div id="notification" class="notification">Berhasil Menambahkan Data</div>


    <script src="{{ asset('js/popta.js') }}"></script>




</body>
</html>
