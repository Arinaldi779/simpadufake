<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Akademik</title>
    <link rel="stylesheet" href="{{ asset('css/akademik.css') }}">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header class="main-header">
      <div class="left-header">
        <img src="{{ asset('images/logo poliban.png') }}" alt="Logo" class="logo-icon" />
        <span class="app-title">SIMPADU</span>
      </div>
      <div class="right-header">
        <img src="{{ asset('images/Bell.png') }}" alt="Notifikasi" class="bell-icon" />
        <img src="{{ asset('images/Test Account.png') }}" alt="User" class="logo-icon" id="user-icon" style="cursor: pointer;" />
        <form id="logout-form" method="POST" action="{{ route('logout') }}" style="display: none;">
          @csrf
          <button type="submit" class="logout-button">Logout</button>
        </form>
      </div>
    </header>

    <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

    <div class="container">
        <aside class="sidebar">
          <div class="sidebar-header">
            <img src="{{ asset('images/Graduation Cap (1).png') }}" alt="Logo" class="logo-icon">
            <h2>Akademik</h2>
          </div>
          <hr class="divider">
          <nav>
            <ul>
              <li class="active">
                <img src="{{ asset('images/Group 1.png') }}" alt="Dashboard"> Dashboard
              </li>
              <li>
                <a href="{{ route('tahunakademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                  <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik"> Tahun Akademik
                </a>
              </li>
              <li>
                <a href="{{ route('kelas') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                  <img src="{{ asset('images/Class.png') }}" alt="Kelas"> Kelas
                </a>
              </li>
              <li>
                <a href="{{ route('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                  <img src="{{ asset('images/People.png') }}" alt="Mahasiswa"> Mahasiswa
                </a>
              </li>
            </ul>
          </nav>
        </aside>


        <main class="main-content">
            <div class="mini-card-wrapper">
              <div class="mini-card">
                <div class="top-row">
                    <div class="icon-container blue">
                        <img src="{{ asset('images/Group 7.png') }}" alt="Tahun Akademik">
                    </div>
                    <div class="text-container">
                        <p class="label">Tahun Akademik Aktif</p>
                        <h3>2025/2026</h3>
                       
                    </div>
                </div>
                
                <button class="action-button blue">Date : {{ \Carbon\Carbon::now()->translatedFormat('d F Y') }}</button>
            </div>

                <div class="mini-card">
                  <div class="top-row">
                    <div class="icon-container green">
                      <img src="{{ asset('images/Group 8.png') }}" alt="Icon Tahun Akademik">
                    </div>
                    <div class="text-container">
                      <p class="label">Tahun Akademik Aktif</p>
                      <h3>2025/2026</h3>
                    </div>
                  </div>
                  <a href="{{ route('tahunakademik') }}" class="action-button green" style="text-decoration: none;">Kelola Tahun Akademik</a>

                </div>

                <div class="mini-card">
                  <div class="top-row">
                    <div class="icon-container purple">
                      <img src="{{ asset('images/Group 9.png') }}" alt="Icon Kelas Aktif">
                    </div>
                    <div class="text-container">
                      <p class="label">Kelas Aktif</p>
                      <h3>27</h3>
                    </div>
                  </div>
                  
                  <a href="{{ route('kelas') }}" class="action-button purple" style="text-decoration: none;">Lihat Semua Kelas</a>
                  
                </div>

                <div class="mini-card">
                  <div class="top-row">
                    <div class="icon-container red">
                      <img src="{{ asset('images/Group 10.png') }}" alt="Icon Program Studi">
                    </div>
                    <div class="text-container">
                      <p class="label">Mahasiswa</p>
                      <h3>27</h3>
                    </div>
                  </div>
                  <a href="{{ route('mahasiswa') }}" class="action-button red" style="text-decoration: none;" >Lihat Daftar Mahasiswa</a>
                </div>
            </div>

            <div class="bottom-section">
                <div class="notifications">
                  <h3>Notifikasi Penting</h3>
                  <div class="alert danger">
                    <img src="{{ asset('images/Error.png') }}" alt="Warning" class="alert-icon">
                    Belum input nilai untuk 5 kelas
                  </div>
                  <div class="alert info">
                    <img src="{{ asset('images/Info.png') }}" alt="Info" class="alert-icon">
                    12 Mahasiswa belum melakukan KRS
                  </div>
                </div>
              
                <div class="quick-actions">
                  <h3>Aksi Cepat</h3>
                  <button id="add-akademik-button">
                        <img src="{{ asset('images/Teacher.png') }}" alt="Jadwal" class="button-icon">
                        Buat Tahun Akademik
                    </button>
                  <button id="add-kelas-button">
                        <img src="{{ asset('images/Class2.png') }}" alt="Jadwal" class="button-icon">
                        Buat Kelas 
                  </button>
                  <button id="add-mahasiswa-button">
                        <img src="{{ asset('images/Attendance.png') }}" alt="Jadwal" class="button-icon">
                        Tambah Mahasiswa 
                  </button>
                </div>
            </div>

            <div class="popup-overlay" id="akademik-popup">
            <div class="popup-content">
              <h2>Tambah Tahun Akademik</h2>
              <form id="form-akademik" action="{{ route('thnAk.create') }}" method="POST">
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
                <button type="submit" class="btn-simpan-akademik">✔ Simpan</button>
                <button type="button" class="btn-cancel-akademik">✘ Batal</button>
              </div>

            </div>
          </div>

          <div class="popup-overlay" id="kelas-popup">
                <div class="popup-content">
                    <h2>Tambah Kelas</h2>

                    <div class="form-group">
                        <input type="text" placeholder="Nama Kelas *">
                    </div>
                
                    
                    <div class="form-group filter-group">
                    <select id="prodi">
                        <option>Program Studi *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="semester">
                        <option>Angkatan *</option>
                    </select>
                    </div>
                    <div class="button-group">
                        <button class="btn-simpan-kelas">✔ Simpan</button>
                        <button type="button" class="btn-cancel-kelas">✘ Batal</button>

                    </div>
                </div>
          </div>

          <div class="popup-overlay" id="mahasiswa-popup">
                <div class="popup-content">
                    <h2>Tambah Mahasiswa</h2>

                    <div class="form-group">
                        <input type="text" placeholder="NIM *">
                    </div>
                    <div class="form-group">
                        <input type="text" placeholder="Nama Mahasiswa *">
                    </div>
                    <div class="form-group filter-group">
                        <select id="kelas">
                            <option>Kelas *</option>
                        </select>
                    </div>
                     <div class="form-group filter-group">
                        <input type="number" placeholder="Nomor Absen *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Status *</option>
                            <option>Aktif</option>
                            <option>Tidak Aktif</option>
                        </select>
                        </div>
                    <div class="button-group">
                        <button type="button" class="btn-simpan-mahasiswa">✔ Simpan</button>
                        <button type="button" class="btn-cancel-mahasiswa">✘ Batal</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script src="{{ asset('js/akademik.js') }}"></script>
    <script>
        function toggleSidebar() {
          const sidebar = document.querySelector('.sidebar');
          sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>