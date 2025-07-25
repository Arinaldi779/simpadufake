<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Manajemen Mahasiswa</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="{{ asset('css/mahasiswa.css') }}">
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
                    <a href="{{ route('akademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                    <img src="{{ asset('images/Group 1 (1).png') }}" alt="Dashboard"> Dashboard
                    </a>
                </li>
                <li>
                    <a href="{{ route('tahunakademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                    <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik"> Tahun Akademik
                    </a>
                </li>
                <li>
                    <a href="{{ route('kelas') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                    <img src="{{ asset('images/Class.png') }}" alt="Kelas"> Kelas
                    </a>
                </li>
                <li class="active">
                    <a href="{{ route('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">
                    <img src="{{ asset('images/People.png') }}" alt="Mahasiswa"> Mahasiswa
                    </a>
                </li>
                </ul>
            </nav>
            </aside>


        <main class="main-content">
            <div class="breadcrumb-line-inline">
            <a href="{{ route('akademik') }}" class="grey-text">Dashboard</a>  &gt; <strong>Mahasiswa</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Manajemen Mahasiswa</h2>
                <button class="add-button">+ Tambah Mahasiswa</button>
            </div>
            <div class="filter-box">
                <div class="filter-group">
                <label for="tahun">NIM</label>
                    <select id="nim" name="prodi">
                        <option>NIM</option>
                        @foreach ($dataAll->pluck('nim')->unique() as $nim)
                            <option value="{{ $nim }}" {{ request('nim') == $nim ? 'selected' : '' }}>{{ $nim }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="filter-group">    
                <label for="tahun">Nama</label>
                    <select id="nama" name="nama">
                        <option>Nama</option>
                        @foreach ($dataAll->pluck('nim')->unique() as $nim)
                            <option value="{{ $nim }}" {{ request('nim') == $nim ? 'selected' : '' }}>{{ $nim }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="filter-group">    
                <label for="tahun">Kelas</label>
                    <select id="kelas" name="kelas">
                        <option>Kelas</option>
                        @foreach ($dataAll->pluck('kelas.nama_kelas')->unique() as $kelas)
                            <option value="{{ $kelas }}" {{ request('kelas') == $kelas ? 'selected' : '' }}>{{ $kelas }}</option>
                        @endforeach
                    </select>
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
                        </tr>
                    </thead>
                    <tbody>
                    @foreach ($data as $klsMaster)
                    <tr>
                        <td>{{ $klsMaster->nim }}</td>
                        <td>{{ $klsMaster->nim }}</td>
                        <td>{{ $klsMaster->kelas->nama_kelas }}</td>
                        <td>{{ $klsMaster->no_absen }}</td>
                        <td>
                            <form action="{{ route('kelas-master.mhsStatus', $klsMaster->id_kelas_master) }}" method="POST">
                                @csrf
                                @method('PATCH')
                                <button class="status-btn {{ $klsMaster->status === 'Y' ? 'btn-aktif' : 'btn-nonaktif' }}">
                                    {{ $klsMaster->status === 'Y' ? 'Aktif' : 'Tidak Aktif' }}
                                </button>
                            </form>
                        </td>
                    </tr>
                    @endforeach
                    </tbody>

                </table>
                <div class="pagination">
                    <div class="page-buttons">
                        {{ $data->links('components.pagination-custom') }}
                    </div>
                </div>
            </div>
            <form action="{{ route('mhsMaster.create') }}" method="POST" id="form-mahasiswa">
                @csrf

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
        </form>
        </div>
        </main>
    </div>
    <script src="{{ asset('js/popma.js') }}"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="{{ asset('js/popma.js') }}"></script>
    <script>
        $(document).ready(function() {
            $('#nama').select2({
                width: 'resolve'
            });
        });
        $(document).ready(function() {
            $('#nim').select2({
                width: 'resolve'
            });
        });
        $(document).ready(function() {
            $('#kelas').select2({
                width: 'resolve'
            });
        });
    </script>
    @if(session('success'))
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        showNotification("{{ session('success') }}");
    });
    </script>
    @endif

</body>
</html>
