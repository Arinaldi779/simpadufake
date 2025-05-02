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
          <img src="{{ asset('images/Test Account.png') }}" alt="User" class="logo-icon" />
          <form method="POST" action="{{ route('logout') }}" class="d-none">
            @csrf
            <button type="submit" class="btn btn-danger">Logout</button>
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
                <a href="{{ url('tahunakademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                  <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik"> Tahun Akademik
                  </a>
            
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
            <div class="mini-card-wrapper">
                <div class="mini-card">
                  <div class="top-row">
                    <div class="icon-container blue">
                      <img src="{{ asset('images/Group 7.png') }}" alt="Icon Tahun Akademik">
                    </div>
                    <div class="text-container">
                      <p class="label">Tahun Akademik Aktif</p>
                      <h3>2025/2026</h3>
                    </div>
                  </div>
                  <a href="/tahunakademik" class="action-button blue" style="text-decoration: none;">Kelola Tahun Akademik</a>

                </div>

                <div class="mini-card">
                  <div class="top-row">
                    <div class="icon-container green">
                      <img src="{{ asset('images/Group 8.png') }}" alt="Icon Kelas Aktif">
                    </div>
                    <div class="text-container">
                      <p class="label">Kelas Aktif</p>
                      <h3>27</h3>
                    </div>
                  </div>
                  
                  <a href="/kelas" class="action-button green" style="text-decoration: none;">Lihat Semua Kelas</a>
                  
                </div>

                <div class="mini-card">
                  <div class="top-row">
                    <div class="icon-container purple">
                      <img src="{{ asset('images/Group 9.png') }}" alt="Icon Mata Kuliah">
                    </div>
                    <div class="text-container">
                      <p class="label">Mata Kuliah Aktif</p>
                      <h3>27</h3>
                    </div>
                  </div>
                  <button class="action-button purple" >Lihat Daftar Mata Kuliah</button>
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
                  <a href="/mahasiswa" class="action-button red" style="text-decoration: none;" >Lihat Daftar Mahasiswa</a>
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
                  <button>
                    <img src="{{ asset('images/Teacher.png') }}" alt="Jadwal" class="button-icon">
                    Menetapkan jadwal akademik
                  </button>
                  <button>
                    <img src="{{ asset('images/Add.png') }}" alt="Tahun Akademik" class="button-icon">
                    Buat Tahun Akademik
                  </button>
                  <button>
                    <img src="{{ asset('images/Class2.png') }}" alt="KRS" class="button-icon">
                    Kelola KRS
                  </button>
                  <button>
                    <img src="{{ asset('images/Attendance.png') }}" alt="Semester" class="button-icon">
                    Pengelolaan semester
                  </button>
                </div>
            </div>
        </main>
    </div>

    <script>
        function toggleSidebar() {
          const sidebar = document.querySelector('.sidebar');
          sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>