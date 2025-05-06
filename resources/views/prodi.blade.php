<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Akademik</title>
    <link rel="stylesheet" href="{{ asset('css/prodi.css') }}">
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
          <img src="{{ asset('images/Test Account.png') }}" alt="Akun" class="logo-icon" />
        </div>
    </header>

    <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

    <div class="container">
        <aside class="sidebar">
            <div class="sidebar-header">
              <img src="{{ asset('images/University Campus.png') }}" alt="Logo" class="logo-icon">
              <h2>Program Studi</h2>
            </div>
            <hr class="divider">
            <nav>
              <ul>
                <li class="active"><img src="{{ asset('images/Group 1.png') }}" alt="Dashboard"> Dashboard</li>
                <li>
                    <a href="{{ route('kurikulum') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/Calendar.png') }}" alt="kurikulum"> Kurikulum
                    </a>
                </li>
                <li>
                    <a href="{{ route('matakuliah') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/Book.png') }}" alt="matkul"> MataKuliah
                    </a>
                </li>
                <li>
                    <a href="{{ route('dosenajar') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/People.png') }}" alt="dosenajar"> Dosen Ajar
                    </a>
                </li>
                <li>
                    <a href="{{ route('presensi') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/University Campus.png') }}" alt="presensi"> Presensi
                    </a>
                </li>
                <li>
                    <a href="{{ route('nilai') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/Scorecard.png') }}" alt="nilai"> Nilai
                    </a>
                </li>
                <li>
                    <a href="{{ route('khskrs') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/School.png') }}" alt="khskrs"> KHS & KRS
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
                    <button class="action-button blue">Lihat Tahun Akademik</button>
                </div>

                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container green">
                            <img src="{{ asset('images/Group 8.png') }}" alt="Dosen Aktif">
                        </div>
                        <div class="text-container">
                            <p class="label">Dosen Aktif</p>
                            <h3>27</h3>
                        </div>
                    </div>
                    <button class="action-button green">Lihat Semua Dosen</button>
                </div>

                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container purple">
                            <img src="{{ asset('images/Group 9.png') }}" alt="Mata Kuliah Aktif">
                        </div>
                        <div class="text-container">
                            <p class="label">Mata Kuliah Aktif</p>
                            <h3>27</h3>
                        </div>
                    </div>
                    <button class="action-button purple">Lihat Daftar Mata Kuliah</button>
                </div>

                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container red">
                            <img src="{{ asset('images/Group 10.png') }}" alt="Kelas Aktif">
                        </div>
                        <div class="text-container">
                            <p class="label">Kelas Aktif</p>
                            <h3>27</h3>
                        </div>
                    </div>
                    <button class="action-button red">Semua Kelas</button>
                </div>
            </div>

            <div class="bottom-section">
                <div class="notifications">
                    <h3>Notifikasi Penting</h3>
                    <div class="alert danger">
                        <img src="{{ asset('images/Add Bookmark.png') }}" alt="Warning" class="alert-icon">
                        Presensi TI-4D
                    </div>
                    <div class="alert info">
                        <img src="{{ asset('images/Add Bookmark.png') }}" alt="Info" class="alert-icon">
                        Kelas Telah Ditambah
                    </div>
                </div>

                <div class="quick-actions">
                    <h3>Aksi Cepat</h3>
                    <button>
                        <img src="{{ asset('images/Teacher.png') }}" alt="Jadwal" class="button-icon">
                        Assign Dosen
                    </button>
                    <button>
                        <img src="{{ asset('images/Add.png') }}" alt="Tahun Akademik" class="button-icon">
                        Tambah MataKuliah
                    </button>
                    <button>
                        <img src="{{ asset('images/Class2.png') }}" alt="KRS" class="button-icon">
                        Tambah Kelas
                    </button>
                    <button>
                        <img src="{{ asset('images/Attendance.png') }}" alt="Semester" class="button-icon">
                        Input Presensi
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
