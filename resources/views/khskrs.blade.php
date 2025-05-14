<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KHS & KRS</title>
    <link rel="stylesheet" href="{{ asset('css/khskrs.css') }}">
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
            <img src="{{ asset('images/Test Account.png') }}" alt="Account" class="logo-icon" />
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
                <li class="active">
                        <img src="{{ asset('images/School.png') }}" alt="KHS KRS"> KHS & KRS
                </li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="breadcrumb-line-inline">
                <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>KHS & KRS</strong>
            </div>

            <br>
            <div class="header-flex">
                <h2 class="page-title">KHS</h2>
                <button class="add-khs-button">+ Tambah KHS</button>
            </div>

            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Tahun Akademik</label>
                    <select id="tahun">
                        <option>Tahun Akademik</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">Semester</label>
                    <select id="status">
                        <option>Ganjil / Genap</option>
                    </select>
                </div>
                <button type="submit" class="btn-filter">Filter</button>
            </div>

            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NAMA MATAKULIAH</th>
                            <th>SKS</th>
                            <th>DOSEN PENGAJAR</th>
                            <th>STATUS</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Database</td>
                            <td>4</td>
                            <td>Ahmad</td>
                            <td><span class="status active">Terpilih</span></td>
                            <td><a href="{{ route('editkhs') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>

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

            <br><br>

            <div class="header-flex">
                <h2 class="page-title">KRS</h2>
                <button class="add-krs-button">+ Tambah KRS</button>
            </div>

            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Tahun Akademik</label>
                    <select id="tahun">
                        <option>Tahun Akademik</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="semester">Semester</label>
                    <select id="semester">
                        <option>Ganjil / Genap</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="nim">NIM</label>
                    <select id="nim">
                        <option>NIM Mahasiswa</option>
                    </select>
                </div>
                <button type="submit" class="btn-filter">Filter</button>
            </div>

            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NIM</th>
                            <th>NAMA MATAKULIAH</th>
                            <th>SKS</th>
                            <th>NILAI NUMERIK</th>
                            <th>NILAI</th>
                            <th>BOBOT NILAI</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>C030323063</td>
                            <td>Database</td>
                            <td>4</td>
                            <td>90</td>
                            <td>A</td>
                            <td>Bobot Nilai</td>
                            <td><a href="{{ route('editkrs') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>

                        </tr>
                    </tbody>
                </table>

                <div class="paginationipk">
                    <span>IPK SEMESTER : 3.75</span>
                    <div class="page-buttons">
                        <button>&lt;</button>
                        <button class="current">1</button>
                        <button class="current">2</button>
                        <button class="current">3</button>
                        <button>&gt;</button>
                    </div>
                </div>
            </div>
            <div class="popup-overlay" id="khs-popup">
                <div class="popup-content">
                    <h2>Tambah KHS</h2>

                    <div class="form-group">
                    <input type="text" placeholder="Nama Matakuliah *">
                    </div>
                    <div class="form-group filter-group">
                    <input type="text" placeholder="KHS *">
                    </div>
                    <div class="form-group filter-group">
                    <input type="text" placeholder="Nama Dosen Pengajar *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Status *</option>
                            <option>Terpilih</option>
                            <option>Tidak Terpilih</option>
                        </select>
                        </div>
                    <div class="button-group">
                        <button class="btn-simpan">✔ Simpan</button>
                        <button class="btn-cancel">✘ Batal</button>
                    </div>
                </div>
            </div>
            <div class="popup-overlay" id="krs-popup">
                <div class="popup-content">
                    <h2>Tambah KHS</h2>

                    <div class="form-group">
                    <input type="text" placeholder="NIM *">
                    </div>
                    <div class="form-group filter-group">
                    <input type="text" placeholder="Nama Mata Kuliah *">
                    </div>
                    <div class="form-group filter-group">
                    <input type="text" placeholder="SKS *">
                    </div>
                    <div class="form-group filter-group">
                    <input type="text" placeholder="Nilai Numerik *">
                    </div>
                    <div class="form-group filter-group">
                    <input type="text" placeholder="Nilai *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Bobot Nilai *</option>
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
    <script src="{{ asset('js/khskrs.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
