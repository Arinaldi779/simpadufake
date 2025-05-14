<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Presensi</title>
    <link rel="stylesheet" href="{{ asset('css/presensi.css') }}">
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
                <li>
                    <a href="{{ route('dosenajar') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/People.png') }}" alt="Dosen Ajar"> Dosen Ajar
                    </a>
                </li>
                <li class="active">
                        <img src="{{ asset('images/University Campus.png') }}" alt="Presensi"> Presensi
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
            {{-- Presensi Dosen --}}
            <div class="breadcrumb-line-inline">
              <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>Presensi</strong>
            </div>
            <br>

            <div class="header-flex">
                <h2 class="page-title">Dosen</h2>
                <button class="add-presensi-dosen-button">+ Tambah Presensi Dosen</button>
            </div>

            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Nama</label>
                    <select id="tahun">
                        <option>Nama Dosen</option>
                    </select>
                    
                </div>
                <div class="filter-group">
                    <label for="status">Nama</label>
                    <select id="status">
                        <option>Nama Mata Kuliah</option>
                    </select>
                </div>
                <button type="submit" class="btn-filter">Filter</button>
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
                            <th>JAM MULAI-JAM SELESAI</th>
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
                            <td>09.00 - 10.20</td>
                            <td><span class="status active">Hadir</span></td>
                            <td><a href="{{ route('editpresensidosen') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>

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

            {{-- Presensi Mahasiswa --}}
            <br><br>
            <div class="header-flex">
                <h2 class="page-title">Mahasiswa</h2>
                <button class="add-presensi-mahasiswa-button">+ Tambah Presensi Mahasiswa</button>
            </div>

            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Nama</label>
                    <select id="tahun">
                        <option>Nama Mahasiswa</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">Nama</label>
                    <select id="status">
                        <option>Nama Mata Kuliah</option>
                    </select>
                </div>
                <button type="submit" class="btn-filter">Filter</button>
            </div>

            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NAMA MAHASISWA</th>
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
                            <td><span class="status active">Hadir</span></td>
                            <td><a href="{{ route('editpresensimahasiswa') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>

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
            <div class="popup-overlay" id="presensi-dosen-popup">
                <div class="popup-content">
                    <h2>Tambah Presensi Dosen</h2>

                    <div class="form-group">
                        <input type="text" placeholder="Nama Dosen *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Prodi *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Mata Kuliah *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Kelas *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Semester *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <label for="jam-mulai">Jam Mulai:</label>
                        <input type="time" id="jam-mulai" name="jam-mulai">
                        <label for="jam-selesai">Jam Selesai:</label>
                        <input type="time" id="jam-selesai" name="jam-selesai">
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
            <div class="popup-overlay" id="presensi-mahasiswa-popup">
                <div class="popup-content">
                    <h2>Tambah Presensi Mahasiswa</h2>

                    <div class="form-group">
                        <input type="text" placeholder="Nama Mahasiswa *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Prodi *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Mata Kuliah *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Kelas *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Semester *</option>
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
    <script src="{{ asset('js/absen.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
