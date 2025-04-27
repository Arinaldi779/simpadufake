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
          <img src="{{ asset('images/bell.png') }}" alt="Bell" class="bell-icon" />
          <img src="{{ asset('images/test account.png') }}" alt="Akun" class="logo-icon" />
          <form action="{{ route('logout') }}" method="POST">
            @csrf
            <button type="submit"><img src="{{ asset('images/logo poliban.png') }}" alt="Akun" class="logo-icon" /></button>
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
                    <li class="active"><img src="{{ asset('images/group 1.png') }}" alt="Dashboard"> Dashboard</li>
                    <li>
                        <a href="{{ url('tahunakademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                            <img src="{{ asset('images/calendar.png') }}" alt="Tahun Akademik"> Tahun Akademik
                        </a>
                    </li>


                    <li>
                    <a href="{{ url('kelas') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                    <img src="{{ asset('images/class.png') }}" alt="Kelas"> Kelas
                    </a>
                </li>
                    <li>
                    <a href="{{ url('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">  
                    <img src="{{ asset('images/people.png') }}" alt="Mahasiswa"> Mahasiswa</li>
                    </a>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="mini-card-wrapper">
                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container blue">
                            <img src="{{ asset('images/group 7.png') }}" alt="Tahun Akademik">
                        </div>
                        <div class="text-container">
                            <p class="label">Tahun Akademik Aktif</p>
                            <h3>2025/2026</h3>
                        </div>
                    </div>
                    <button class="action-button blue" onclick="window.location.href='{{ url('tahunakademik') }}'">Kelola Tahun Akademik</button>
                </div>

                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container green">
                            <img src="{{ asset('images/group 8.png') }}" alt="Kelas Aktif">
                        </div>
                        <div class="text-container">
                            <p class="label">Kelas Aktif</p>
                            <h3>27</h3>
                        </div>
                    </div>
                    <button class="action-button green" onclick="window.location.href='{{ url('kelas') }}'">Lihat Semua Kelas</button>
                </div>

                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container purple">
                            <img src="{{ asset('images/group 9.png') }}" alt="Mata Kuliah Aktif">
                        </div>
                        <div class="text-container">
                            <p class="label">Belum Tau</p>
                            <h3>27</h3>
                        </div>
                    </div>
                    <button class="action-button purple">Belum Tau</button>
                </div>

                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container red">
                            <img src="{{ asset('images/group 10.png') }}" alt="Program Studi">
                        </div>
                        <div class="text-container">
                            <p class="label">Mahasiswa Aktif</p>
                            <h3>3.321</h3>
                        </div>
                    </div>
                    <button class="action-button red" onclick="window.location.href='{{ url('mahasiswa') }}'">Lihat Semua</button>
                </div>
            </div>

            <div class="bottom-section">
                <div class="notifications">
                    <h3>Notifikasi Penting</h3>
                    <div class="alert danger">
                        <img src="{{ asset('images/error.png') }}" alt="Warning" class="alert-icon">
                        Belum input nilai untuk 5 kelas
                    </div>
                    <div class="alert info">
                        <img src="{{ asset('images/info.png') }}" alt="Info" class="alert-icon">
                        12 Mahasiswa belum melakukan KRS
                    </div>
                </div>

                <div class="quick-actions">
                    <h3>Aksi Cepat</h3>
                    <button>
                        <img src="{{ asset('images/teacher.png') }}" alt="Jadwal" class="button-icon">
                        Menetapkan jadwal akademik
                    </button>
                    <button>
                        <img src="{{ asset('images/add.png') }}" alt="Tahun Akademik" class="button-icon">
                        Buat Tahun Akademik
                    </button>
                    <button>
                        <img src="{{ asset('images/class2.png') }}" alt="KRS" class="button-icon">
                        Kelola KRS
                    </button>
                    <button>
                        <img src="{{ asset('images/attendance.png') }}" alt="Semester" class="button-icon">
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
