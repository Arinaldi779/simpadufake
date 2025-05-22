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
                    <select id="prodi">
                        <option>Program Studi</option>
                    </select>
                </div>
                <div class="filter-group">
                    <select id="status">
                        <option>Semua Status</option>
                        @foreach ($dataAll->pluck('status')->unique() as $status)
                            <option value="{{ $status }}" {{ request('status') == $status ? 'selected' : '' }}>
                            {{ $status === 'Y' ? 'Aktif' : 'Tidak Aktif' }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="filter-group">
                    <input type="text" id="search" placeholder="Cari Nama..." />
                </div>
                <button type="submit" class="btn-filter">Filter</button>
            </div>
            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NIM</th>
                            <th>NAMA</th>
                            <th>KELAS</th>
                            <th>NO ABSEN</th>
                            <th>STATUS</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($dataAll as $klsMaster)
                        <tr>
                                <td>{{ $klsMaster->nim }}</td>
                                <td>{{ $klsMaster->nim }}</td>
                                <td>{{ $klsMaster->kelas->nama_kelas }}</td>
                                <td>{{ $klsMaster->no_absen }}</td>
                                <td>{{ $klsMaster->status_aktif }}</td>
                                <td><a href="{{ route('editmhs') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>                                
                            </tr>
                            @endforeach
                    </tbody>
                </table>
                <div class="pagination">
                    <span>Showing 1 to 10 of 20 results</span>
                    <div class="page-buttons">
                        {{ $dataAll->links('components.pagination-custom') }}
                    </div>
                </div>
            </div>
            <div class="popup-overlay" id="popup">
                <div class="popup-content">
                    <h2>Tambah Mahasiswa</h2>
                    <div class="form-group filter-group">
                        <select id="mahasiswa" name="nim">
                            <option>Nim Mahasiswa *</option>
                            @foreach ($dataJson as $jsonMhs)
                                <option value="{{ $jsonMhs->nim }}">{{ $jsonMhs->nim }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <select id="kelas" name="id_kelas">
                            <option>Kelas *</option>
                            @foreach ($dataKelas as $kelasData)
                                <option value="{{ $kelasData->id_kelas }}">{{ $kelasData->nama_kelas }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group filter-group">
                        <input type="number" placeholder="Nomor Absen *" name="no_absen" />
                    </div>
                    <div class="form-group filter-group">
                        <select name="status">
                            <option value="">Status *</option>
                            <option value="Y">Aktif</option>
                            <option value="T">Tidak Aktif</option>
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
    <script src="{{ asset('js/popma.js') }}"></script>
</body>
</html>
