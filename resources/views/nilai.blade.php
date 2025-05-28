<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nilai</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="{{ asset('css/nilai.css') }}">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<style>
    .select2-container--default .select2-selection--single {
        padding: 12px 20px 10px 16px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: #f2f2f2;
        color: #555;
        width: 100%;
        box-sizing: border-box;
        height: auto;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #555;
        line-height: 1.5;
        padding-left: 0;
        padding-right: 0;
    }

    .select2-container--default .select2-selection--single .select2-selection__arrow {
        height: 100%;
        top: 0;
        right: 16px;
    }

    .select2-container {
        width: 100% !important;
    }
</style>
<body>
    <header class="main-header">
        <div class="left-header">
            <img src="{{ asset('images/logo poliban.png') }}" alt="Logo" class="logo-icon" />
            <span class="app-title">SIMPADU</span>
        </div>
        <div class="right-header">
            <img src="{{ asset('images/Bell.png') }}" alt="Logo" class="bell-icon" />
            <img src="{{ asset('images/Test Account.png') }}" alt="Logo" class="logo-icon" />
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
                <li class="active">
                        <img src="{{ asset('images/Scorecard.png') }}" alt="Nilai"> Nilai
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
                <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>Nilai</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Nilai</h2>
                <button class="add-nilai-button">+ Tambah Nilai</button>
            </div>
            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Nama</label>
                    <select id="namamhs" class="select2">
                        <option>Nama Mahasiswa</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">Nama</label>
                    <select id="namamk" class="select2">
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
                            <th>NILAI</th>
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
                            <td><span>A</span></td>
                            <td><a href="{{ route('editnilai') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>

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
            <div class="popup-overlay" id="nilai-popup">
                <div class="popup-content">
                    <h2>Tambah Nilai</h2>

                    <div class="form-group">
                        <input type="text" id="namaMahasiswaNilai" placeholder="Nama Mahasiswa *">
                    </div>
                    <div class="form-group filter-group">
                        <select id="prodiNilai">
                            <option value="">Program Studi *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select id="mataKuliahNilai">
                            <option value="">Mata Kuliah *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select id="kelasNilai">
                            <option value="">Kelas *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select id="semesterNilai">
                            <option value="">Semester *</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select id="nilaiMahasiswa">
                            <option value="">Nilai *</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select id="statusNilai">
                            <option value="">Status *</option>
                            <option value="Aktif">Aktif</option>
                            <option value="Tidak Aktif">Tidak Aktif</option>
                        </select>
                    </div>

                    <div class="button-group">
                        <button class="btn-simpan" id="simpanNilai">✔ Simpan</button>
                        <button class="btn-cancel">✘ Batal</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#namamk').select2({
                width: 'resolve'
            });
        });
        $(document).ready(function() {
            $('#namamhs').select2({
                width: 'resolve'
            });
        });
    </script>
    <script src="{{ asset('js/nilai.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
