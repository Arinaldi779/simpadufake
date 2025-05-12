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
                    <a href="{{ url('/') }}" style="text-decoration: none; color: inherit; display: flex; align-items: center; gap: 10px;">    
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
                <a href="{{ url('/') }}" class="grey-text">Dashboard</a>  &gt; <strong>Kelas</strong>
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
                    <select id="prodi" name="prodi">
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
                    <select id="angkatan" name="thnAk">
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
                    <span>Showing 1 to 10 of 20 results</span>
                    <div class="page-buttons">
                        {{ $data->links('components.pagination-custom') }}
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
                    <select id="prodi">
                        <option>Program Studi *</option>
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="semester">
                        <option>Angkatan *</option>
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

    <script src="{{ asset('js/poptk.js') }}"></script>
</body>
</html>
