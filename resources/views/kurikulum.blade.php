<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kurikulum</title>
    <link rel="stylesheet" href="{{ asset('css/kurikulum.css') }}">
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
                        <a href="{{ route('prodi') }}" style="display: flex; align-items: center; text-decoration: none; color: inherit; gap: 10px;">
                            <img src="{{ asset('images/Group 1.png') }}" alt="Dashboard"> Dashboard
                        </a>
                    </li>

                    <li class="active"><img src="{{ asset('images/Calendar.png') }}" alt="Kurikulum"> Kurikulum</li>
                    <li>
                        <a href="{{ route('matakuliah') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                            <img src="{{ asset('images/Book.png') }}" alt="Matkul"> MataKuliah
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
            <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>Kurikulum</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Kurikulum</h2>
                <button class="add-button">+ Tambah Kurikulum</button>
            </div>

            <form action="{{ route('kurikulum') }}" method="GET">
            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Nama</label>
                    <select id="tahun" name="mk">
                        <option value="">Mata Kuliah</option>
                        @foreach ($dataAll as $dataKurikulum)
                        <option value="{{ $dataKurikulum->id_mk }}" {{ request('mk') == $dataKurikulum->id_mk ? 'selected' : '' }}>
                            {{ optional($dataKurikulum->mataKuliah)->nama_mk }}
                        </option>
                        @endforeach
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">Tahun</label>
                    <select id="status" name="thnAk">
                        <option value="">Tahun Kurikulum</option>
                        @foreach ($dataAll->pluck('tahunAkademik')->filter()->unique('id_thn_ak') as $dataKurikulum)
                        <option value="{{ $dataKurikulum->id_thn_ak }}" {{ request('thnAk') == $dataKurikulum->id_thn_ak ? 'selected' : '' }}>
                        {{ $dataKurikulum->nama_thn_ak }}
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
                            <th>MATA KULIAH</th>
                            <th>TAHUN</th>
                            <th>KETERANGAN</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($data as $dataKurikulum)
                        <tr>
                            <td>{{ $dataKurikulum->mataKuliah->nama_mk }}</td>
                            <td>{{ $dataKurikulum->tahunAkademik->nama_thn_ak }}</td>
                            <td>{{ (!$dataKurikulum->ket) ? "Tidak Ada Keterangan" : $dataKurikulum->ket }}</td>
                            <td><button class="edit-btn">Edit</button></td>
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
                <div class="popup-content">
                    <h2>Tambah Kurikulum</h2>
                    <form action="{{ route('kurikulum.create') }}" method="POST">
                        @csrf
                    <div class="form-group filter-group">
                    <select id="id_mk" name="id_mk">
                        <option value="">Mata Kuliah *</option>
                        @foreach ($dataMk as $mkData)
                        <option value="{{ $mkData->id_mk }}">{{ $mkData->nama_mk }} *</option>
                        @endforeach
                    </select>
                    </div>
                    <div class="form-group filter-group">
                    <select id="tahunakademik" name="id_thn_ak">
                        <option value="">Tahun Akademik</option>
                        @foreach ($dataThnAk as $thnAkData)
                        <option value="{{ $thnAkData->id_thn_ak }}">{{ $thnAkData->nama_thn_ak }} *</option>
                        @endforeach
                    </select>
                    </div>

                    <div class="form-group">
                    <input type="text" placeholder="Keterangan *" name="ket">
                    </div>

                    <div class="button-group">
                        <button class="btn-simpan">✔ Simpan</button>
                        <button class="btn-cancel">✘ Batal</button>
                    </div>
                </div>
                </form>
            </div>
        </main>
    </div>
    
    <script src="{{ asset('js/kurikulum.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
