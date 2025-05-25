<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelas</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="{{ asset('css/kelas.css') }}">
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
                    <a href="{{ route('akademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                    <img src="{{ asset('images/Group 1 (1).png') }}" alt="Dashboard"> Dashboard
                    </a>
                </li>
                <li>
                    <a href="{{ route('tahunakademik') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                    <img src="{{ asset('images/Calendar.png') }}" alt="Tahun Akademik"> Tahun Akademik
                    </a>
                </li>
                <li class="active">
                    <img src="{{ asset('images/Class.png') }}" alt="Kelas"> Kelas
                </li>
                <li>
                    <a href="{{ route('mahasiswa') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
                    <img src="{{ asset('images/People.png') }}" alt="Mahasiswa"> Mahasiswa
                    </a>
                </li>
                </ul>
            </nav>
            </aside>


        <main class="main-content">
            <div class="breadcrumb-line-inline">
                <a href="{{ route('akademik') }}" class="grey-text">Dashboard</a>  &gt; <strong>Kelas</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Kelas</h2>
                <button class="add-button">+ Tambah Kelas</button>
            </div>

            <form action="{{ route('kelas') }}" method="GET" >
            <div class="filter-box">
                <div class="filter-group">
                    <label for="prodi">Program Studi</label>
                    <select id="prodi" name="prodi" class="select2">
                        <option value="">Semua Prodi</option>
                        @foreach ($dataAll->pluck('prodi')->filter()->unique('id_prodi') as $dataKelas)
                            <option value="{{ $dataKelas->id_prodi }}" {{ request('prodi') == $dataKelas->nama_thn_ak ? 'selected' : '' }}>
                                {{ $dataKelas->nama_prodi }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="filter-group">
                    <label for="angkatan">Angkatan</label>
                    <select id="angkatan" name="thnAk" class="select2">
                        <option value="">Semua Angkatan</option>
                        @foreach ($dataAll->pluck('tahunAkademik')->filter()->unique('id_thn_ak') as $dataKelas)
                        <option value="{{ $dataKelas->id_thn_ak }}" {{ request('thnAk') == $dataKelas->nama_thn_ak ? 'selected' : '' }}>
                        {{ $dataKelas->nama_thn_ak }}
                        </option>
                        @endforeach
                    </select>
                </div>
                <button type="submit" class="btn-filter">Filter</button>
            </div>
        </form>
            
        
            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NAMA KELAS</th>
                            <th>PRODI</th>
                            <th>ANGKATAN</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($data as $dataKelas)
                        <tr>
                            <td>{{ $dataKelas->nama_kelas }}</td>
                            <td>{{ $dataKelas->prodi->nama_prodi }}</td>
                            <td>{{ $dataKelas->tahunAkademik->nama_thn_ak }}</td>
                            <td><a href="{{ route('editkls') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>
    
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
            <div class="popup-overlay" id="popup">
                <form method="POST" action="{{ route('tambahKelas') }}" id="form-tambah-kelas">
                    @csrf
                <div class="popup-content">
                    <h2>Tambah Kelas</h2>

                    <div class="form-group">
                        <input type="text" id="nama_kelas" name="nama_kelas" placeholder="Nama Kelas *">
                    </div>

                    <div class="form-group">
                        <input type="text" id="nama_kelas" name="alias" placeholder="Alias *">
                    </div>
                
                    <div class="form-group filter-group">
                            <select name="id_prodi" id="prodi" class="select2">
                            <option value="" disabled selected>Program Studi *</option>
                                @foreach ($dataProdi as $prodi)
                                    <option value="{{ $prodi->id_prodi }}">{{ $prodi->nama_prodi }}</option>
                                @endforeach
                            </select>
                    </div>
                    <div class="form-group filter-group">
                        <select name="id_thn_ak" id="angkatan" class="select2">
                            <option value="" disabled selected>Angkatan *</option>
                            @foreach ($dataThnAk as $dataTahun)
                                <option value="{{ $dataTahun->id_thn_ak }}">{{ $dataTahun->nama_thn_ak . $dataTahun->smt }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="button-group">
                        <button class="btn-simpan" id="btn-simpan-kelas">✔ Simpan</button>
                        <button class="btn-cancel">✘ Batal</button>
                    </div>
                </div>
            </form>

            </div>

        </main>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="{{ asset('js/poptk.js') }}"></script>
    <script>
        $(document).ready(function() {
            $('#prodi').select2({
                width: 'resolve'
            });
        });
        $(document).ready(function() {
            $('#angkatan').select2({
                width: 'resolve'
            });
        });
    </script>
</body>
</html>
