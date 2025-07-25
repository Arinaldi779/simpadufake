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
                            <img src="{{ asset('images/Group 8.png') }}" alt="Dosen Aktif">
                        </div>
                        <div class="text-container">
                            <p class="label">Dosen Aktif</p>
                            <h3>27</h3>
                        </div>
                    </div>
                    
                    <a href="{{ route('dosenajar') }}" class="action-button green" style="text-decoration: none;">Lihat Semua Dosen</a>

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
                    <a href="{{ route('matakuliah') }}" class="action-button purple" style="text-decoration: none;">Lihat MataKuliah</a>

                </div>

                <div class="mini-card">
                    <div class="top-row">
                        <div class="icon-container red">
                            <img src="{{ asset('images/Group 10.png') }}" alt="Kelas Aktif">
                        </div>
                        <div class="text-container">
                            <p class="label">Kurikulum Aktif</p>
                            <h3>27</h3>
                        </div>
                    </div>
                    <a href="{{ route('kurikulum') }}" class="action-button red" style="text-decoration: none;">Lihat Kurikulum</a>

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
                    <button id="add-kurikulum-button">
                        <img src="{{ asset('images/Class2.png') }}" alt="Jadwal" class="button-icon">
                        Tambah Kurikulum 
                    </button>

                    
                    <div class="add-button">
                    <button >
                        <img src="{{ asset('images/Add.png') }}" alt="Tahun Akademik" class="button-icon">
                        Tambah MataKuliah
                    </button>
                    </div>

                    <button id="assign-dosen-button">
                        <img src="{{ asset('images/Teacher.png') }}" alt="Jadwal" class="button-icon">
                        Tambah Dosen Ajar
                    </button>

                </div>
            </div>

            <div class="popup-overlay" id="kurikulum-popup">
                <div class="popup-content">
                    <h2>Tambah Kurikulum</h2>

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


            <div class="popup-overlay" id="popup">
                <div class="popup-content">
                    <h2>Tambah MataKuliah</h2>

                    <div class="form-group">
                    <input type="text" placeholder="Nama Mata Kuliah *">
                    </div>
                    
                    
                    <div class="form-group filter-group">
                    <select id="tahunakademik">
                        <option>Prodi *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="tahunakademik">
                        <option>Semester *</option>
                        <option>Ganjil</option>
                        <option>Genap</option>
                    </select>
                    </div>
                    <div class="form-group">
                    <input type="text" placeholder="SKS *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Kelompok *</option>
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
            <div class="popup-overlay" id="assign-popup">
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
            

            <div class="popup-overlay" id="presensi-popup">
                <div class="popup-content">
                    <h2>Tambah Presensi</h2>
                    <h4>Jenis Presensi:</h4>
                    <div class="form-group">
                        <div class="tombol-group">
                            <button id="add-presensi-dosen-button" class="dosen">Dosen</button>
                            <button id="add-presensi-mahasiswa-button" class="mahasiswa">Mahasiswa</button>
                        </div>
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
            <div class="popup-overlay" id="nilai-popup">
                <div class="popup-content">
                    <h2>Tambah Nilai</h2>

                    <div class="form-group">
                        <input type="text" placeholder="Nama Mahasiswa *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Program Studi *</option>
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
                            <option>Nilai *</option>
                            <option>A</option>
                            <option>B</option>
                            <option>C</option>
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

            <div class="popup-overlay" id="nilai-popup">
                <div class="popup-content">
                    <h2>Tambah Nilai</h2>

                    <div class="form-group">
                        <input type="text" placeholder="Nama Mahasiswa *">
                    </div>
                    <div class="form-group filter-group">
                        <select>
                            <option>Program Studi *</option>
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
                            <option>Nilai *</option>
                            <option>A</option>
                            <option>B</option>
                            <option>C</option>
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

            <div class="popup-overlay" id="khskrs-popup">
                <div class="popup-content">
                    <h2>Tambah KHS & KRS</h2>
                    <div class="form-group">
                        <div class="tombol-group">
                            <button id="add-khs-button" class="khs">KHS</button>
                            <button id="add-krs-button" class="krs">KRS</button>
                        </div>
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
    <script src="{{ asset('js/prodi.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
