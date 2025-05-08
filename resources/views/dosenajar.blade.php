<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dosen Ajar</title>
    <link rel="stylesheet" href="{{ asset('css/dosenajar.css') }}">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header class="main-header">
        <div class="left-header">
            <img src="{{ asset('images/logo poliban.png') }}" alt="Logo" class="logo-icon" />
            <span class="app-title">SIMPADU</span>
        </div>
        <div class="right-header">
            <img src="{{ asset('images/Bell.png') }}" alt="Bell" class="bell-icon" />
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
                <li>
                    <a href="{{ route('prodi') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/Group 1.png') }}" alt="Dashboard"> Dashboard
                    </a>
                </li>
                <li>
                    <a href="{{ route('kurikulum') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/Calendar.png') }}" alt="Kurikulum"> Kurikulum
                    </a>
                </li>
                <li>
                    <a href="{{ route('matakuliah') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/Book.png') }}" alt="MataKuliah"> MataKuliah
                    </a>
                </li>
                <li class="active">
                    <img src="{{ asset('images/People.png') }}" alt="Dosen Ajar"> Dosen Ajar
                </li>
                <li>
                    <a href="{{ route('presensi') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/University Campus.png') }}" alt="Presensi"> Presensi
                    </a>
                </li>
                <li>
                    <a href="{{ route('nilai') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/Scorecard.png') }}" alt="Nilai"> Nilai
                    </a>
                </li>
                <li>
                    <a href="{{ route('khskrs') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/School.png') }}" alt="KHS KRS"> KHS & KRS
                    </a>
                </li>

                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="breadcrumb-line-inline">
                <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>Dosen Ajar</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Dosen Ajar</h2>
                <button class="add-button">+ Tambah Dosen Ajar</button>
            </div>

            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Nama</label>
                    <select id="tahun">
                        <option>Nama Dosen</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">NIP</label>
                    <select id="status">
                        <option>NIP Dosen</option>
                    </select>
                </div>
            </div>

            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NAMA DOSEN</th>
                            <th>PROGRAM STUDI</th>
                            <th>MATA KULIAH</th>
                            <th>KELAS</th>
                            <th>SEMESTER</th>
                            <th>STATUS</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Ahmad</td>
                            <td>Teknik Informatika</td>
                            <td>Pemrograman</td>
                            <td>TI-1A</td>
                            <td><span class="status genapganjil">GANJIL</span></td>
                            <td><span class="status active">Aktif</span></td>
                            <td><button class="edit-btn">Edit</button></td>
                        </tr>
                        <tr>
                            <td>Siti</td>
                            <td>Teknik Listrik</td>
                            <td>Listrik</td>
                            <td>TI-3A</td>
                            <td><span class="status genapganjil">GANJIL</span></td>
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
                    <h2>Tambah Dosen</h2>

                    <div class="form-group">
                    <input type="text" placeholder="Nama Dosen *">
                    </div>
                    <div class="form-group filter-group">
                    <select id="programstudi">
                        <option>Program Studi *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="matakuliah">
                        <option>Mata Kuliah *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="Kelas">
                        <option>Kelas *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                        <select id="semester">
                            <option>Semester *</option>
                            <option>Ganjil</option>
                            <option>Genap</option>
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
    <script src="{{ asset('js/dosen.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
