<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manajemen Mahasiswa</title>
    <link rel="stylesheet" href="{{ asset('css/mahasiswa.css') }}">
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

    <!-- Tombol Toggle Sidebar -->
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
                    <li>
                        <a href="{{ url('/') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                            <img src="{{ asset('images/Group 1 (1).png') }}" alt="Dashboard"> Dashboard
                        </a>
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
                    <li class="active">
                        <a href="{{ url('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                            <img src="{{ asset('images/People.png') }}" alt="Mahasiswa"> Mahasiswa
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="breadcrumb-line-inline">
            <a href="{{ url('/') }}" class="grey-text">Dashboard</a>  &gt; <strong>Mahasiswa</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Manajemen Mahasiswa</h2>
                <button class="add-button">+ Tambah Mahasiswa</button>
            </div>
            <div class="filter-box">
                <div class="filter-group">
                    <select id="tahun">
                        <option>Tahun Masuk</option>
                    </select>
                </div>
                <div class="filter-group">
                    <select id="prodi">
                        <option>Program Studi</option>
                    </select>
                </div>
                <div class="filter-group">
                    <select id="status">
                        <option>Semua Status</option>
                    </select>
                </div>
                <div class="filter-group">
                    <input type="text" id="search" placeholder="Cari Nama..." />
                </div>
            </div>
            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NIM</th>
                            <th>NAMA</th>
                            <th>KELAS</th>
                            <th>PRODI</th>
                            <th>TAHUN AKADEMIK</th>
                            <th>STATUS</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>C030323063</td>
                            <td>Yazid</td>
                            <td>TI-1A</td>
                            <td>Teknik Informatika</td>
                            <td>2024/2025</td>
                            <td><span class="status active">Aktif</span></td>
                            <td><button class="edit-btn">Edit</button></td>
                        </tr>
                    </tbody>
                </table>
                <div class="pagination">
                    <span>Showing 1 to 10 of 20 results</span>
                    <div class="page-buttons">
                        <button>&lt;</button>
                        <button class="current">1</button>
                        <button class="current">2</button>
                        <button class="current">3</button>
                        <button>&gt;</button>
                    </div>
                </div>
            </div>
            <div class="popup-overlay" id="popup">
                <div class="popup-content">
                    <h2>Tambah Mahasiswa</h2>

                    <div class="form-group">
                    <input type="text" placeholder="NIM *">
                    </div>
                    <div class="form-group">
                    <input type="text" placeholder="Nama Mahasiswa *">
                    </div>
                    <div class="form-group filter-group">
                    <select id="prodi">
                        <option>Prodi *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="tahunakademik">
                        <option>Tahun Akademik *</option>
                        <option>Ganjil</option>
                        <option>Genap</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="kelas">
                        <option>Kelas*</option>
                    </select>
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
    <script src="{{ asset('js/popma.js') }}"></script>
</body>
</html>
