<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mata Kuliah</title>
    <link rel="stylesheet" href="{{ asset('css/matakuliah.css') }}">
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
                <img src="{{ asset('images/Graduation Cap (1).png') }}" alt="Logo" class="logo-icon">
                <h2>Akademik</h2>
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
                <li class="active">
                    <img src="{{ asset('images/Book.png') }}" alt="MataKuliah"> MataKuliah
                </li>
                <li>
                    <a href="{{ route('dosenajar') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/People.png') }}" alt="Dosen Ajar"> Dosen Ajar
                    </a>
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
                <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>Mata Kuliah</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Mata Kuliah</h2>
                <button class="add-button">+ Tambah Mata Kuliah</button>
            </div>

            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Nama</label>
                    <select id="tahun">
                        <option>Nama Mata Kuliah</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">Kode MK</label>
                    <select id="status">
                        <option>Kode Matakuliah</option>
                    </select>
                </div>
                <button type="submit" class="btn-filter">Filter</button>
            </div>



            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>KODE MATA KULIAH</th>
                            <th>NAMA MATA KULIAH</th>
                            <th>PRODI</th>
                            <th>SEMESTER</th>
                            <th>SKS</th>
                            <th>KELOMPOK</th>
                            <th>STATUS</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>0000</td>
                            <td>Pemrograman</td>
                            <td>Teknik Informatika</td>
                            <td>3</td>
                            <td>3</td>
                            <td>MKB-Berkehidupan Masyarakat</td>
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
                    <h2>Tambah MataKuliah</h2>

                    <div class="form-group">
                    <input type="text" placeholder="Nama Kurikulum *">
                    </div>
                    
                    
                    <div class="form-group filter-group">
                    <select id="tahunakademik">
                        <option>Tahun Akademik *</option>
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
    <script src="{{ asset('js/matkul.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
