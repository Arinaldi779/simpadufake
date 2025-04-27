<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelas</title>
    <link rel="stylesheet" href="{{ asset('css/kelas.css') }}">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <header class="main-header">
        <div class="left-header">
            <img src="{{ asset('images/logo poliban.png') }}" alt="Logo" class="logo-icon">
            <span class="app-title">SIMPADU</span>
        </div>
        <div class="right-header">
            <img src="{{ asset('images/Bell.png') }}" alt="Bell" class="bell-icon">
            <img src="{{ asset('images/Test Account.png') }}" alt="Account" class="logo-icon">
        </div>
    </header>

    <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

    <div class="container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <img src="{{ asset('images/Graduation Cap (1).png') }}" alt="Graduation Cap" class="logo-icon">
                <h2>Akademik</h2>
            </div>
            <hr class="divider">
            <nav>
                <ul>
                    <li>
                    <a href="{{ url('akademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                            <img src="{{ asset('images/Group 1 (1).png') }}" alt="Dashboard"> Dashboard
                        </a>
                    </li>
                    <li>
                    <a href="{{ url('tahunakademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                    
                            <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik"> Tahun Akademik
                        </a>
                    </li>
                    <li class="active">
                       
                            <img src="{{ asset('images/Class.png') }}" alt="Kelas"> Kelas
                      
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
            <div class="breadcrumb-line-inline">
            <a href="{{ url('akademik') }}" class="grey-text">Dashboard</a>  &gt; <strong>Kelas</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Kelas</h2>
                <button class="add-button">+ Tambah Kelas</button>
            </div>
            <div class="filter-box">
                <div class="filter-group">
                    <label for="prodi">Program Studi</label>
                    <select id="prodi">
                        <option>Semua Prodi</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="angkatan">Angkatan</label>
                    <select id="angkatan">
                        <option>Semua Angkatan</option>
                    </select>
                </div>
            </div>
            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NAMA KELAS</th>
                            <th>PRODI</th>
                            <th>ANGKATAN</th>
                            <th>JUMLAH MAHASISWA</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>TI-3D</td>
                            <td>Teknik Informatika</td>
                            <td>2023</td>
                            <td>32</td>
                            <td><button class="edit-btn">Edit</button></td>
                        </tr>
                        <tr>
                            <td>MI-2B</td>
                            <td>Manajemen Informatika</td>
                            <td>2022</td>
                            <td>28</td>
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
                    <h2>Tambah Kelas</h2>

                    <div class="form-group">
                    <input type="text" placeholder="Nama Kelas *">
                    </div>
                
                    
                    <div class="form-group filter-group">
                    <select id="tahunakademik">
                        <option>Tahun Akademik *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="semester">
                        <option>Semester (Ganjil/Genap) *</option>
                        <option>Ganjil</option>
                        <option>Genap</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="prodi">
                        <option>Program Studi *</option>
                    </select>
                    </div>
                    <div class="button-group">
                        <button class="btn-simpan">✔ Simpan</button>
                        <button class="btn-cancel">✘ Batal</button>
                    </div>
                </div>
            </div>
            <div class="popup-overlay" id="popupedit">
                    <div class="popup-content">
                        <h2>Edit Kelas</h2>

                        <div class="form-group">
                        <input type="text" placeholder="Nama Kelas *">
                        </div>

                        <div class="form-group filter-group">
                        <select id="tahunakademik">
                            <option>Tahun Akademik *</option>
                        </select>
                        </div>
                        <div class="form-group filter-group">
                        <select id="semester">
                            <option>Semester (Ganjil/Genap) *</option>
                            <option>Ganjil</option>
                            <option>Genap</option>
                        </select>
                        </div>
                        <div class="form-group filter-group">
                        <select id="prodi">
                            <option>Program Studi *</option>
                        </select>
                        </div>
                        <div class="button-group">
                        <button class="btn-simpan">✔ Simpan</button>
                        <button class="btn-cancel">✘ Batal</button>
                    </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="{{ asset('js/poptk.js') }}"></script>
</body>
</html>
