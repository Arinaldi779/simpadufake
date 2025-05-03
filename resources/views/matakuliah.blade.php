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
                    <li><img src="{{ asset('images/Group 1.png') }}" alt="Dashboard"> Dashboard</li>
                    <li><img src="{{ asset('images/Calendar.png') }}" alt="Kurikulum"> Kurikulum</li>
                    <li class="active"><img src="{{ asset('images/Book.png') }}" alt="MataKuliah"> MataKuliah</li>
                    <li><img src="{{ asset('images/People.png') }}" alt="Dosen Ajar"> Dosen Ajar</li>
                    <li><img src="{{ asset('images/University Campus.png') }}" alt="Presensi"> Presensi</li>
                    <li><img src="{{ asset('images/Scorecard.png') }}" alt="Nilai"> Nilai</li>
                    <li><img src="{{ asset('images/School.png') }}" alt="KHS KRS"> KHS & KRS</li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="breadcrumb-line-inline">
                <span class="grey-text">Dashboard</span> &gt; <strong>Mata Kuliah</strong>
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
            </div>

            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>KODE MATA KULIAH</th>
                            <th>NAMA MATA KULIAH</th>
                            <th>SKS</th>
                            <th>STATUS</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>0000</td>
                            <td>Teknik Informatika</td>
                            <td>23</td>
                            <td><span class="status active">Aktif</span></td>
                            <td><button class="edit-btn">Edit</button></td>
                        </tr>
                        <tr>
                            <td>0000</td>
                            <td>Teknik Listrik</td>
                            <td>24</td>
                            <td><span class="status inactive">Tidak Aktif</span></td>
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
