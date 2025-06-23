<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dosen Ajar</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="{{ asset('css/dosenajar.css') }}">
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
                <li class="active">
                    <img src="{{ asset('images/People.png') }}" alt="Dosen Ajar"> Dosen Ajar
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
                <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>Dosen Ajar</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Dosen Ajar</h2>
                <button class="add-button">+ Tambah Dosen Ajar</button>
            </div>

            @if ($errors->any())
    <div class="alert alert-danger">
        <ul>
            @foreach ($errors->all() as $err)
                <li>{{ $err }}</li>
            @endforeach
        </ul>
    </div>
@endif


            <div class="filter-box">
                <div class="filter-group">
                    <label for="tahun">Nama</label>
                    <select id="tahun">
                        <option>Nama Dosen</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">NIP</label>
                    <select id="status">
                        <option>NIP Dosen</option>
                    </select>
                </div>
                <button type="submit" class="btn-filter">Filter</button>
            </div>

            <div class="table-container">
                <table class="academic-table">
                    <thead>
                        <tr>
                            <th>NAMA DOSEN</th>
                            <th>MATA KULIAH</th>
                            <th>KELAS</th>
                            <th>AKSI</th>
                        </tr>
                    </thead>
                    <tbody>
                            @foreach ($data as $dataKlsMk)
                        <tr>

                            <td>{{ $dataKlsMk->id_pegawai }}</td>
                            <td>{{ $dataKlsMk->kurikulum->mataKuliah->nama_mk }}</td>
                            {{-- <td>{{ $dataKlsMk->id_kurikulum }}</td> --}}
                            <td>{{ $dataKlsMk->kelas->nama_kelas }}</td>
                                <td><a href="{{ route('editdosen') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>
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
                <form {{ route('dosenajar.create') }} method="POST" id="formTambahDosenAjar">
                    @csrf

                <div class="popup-content">
                    <h2>Tambah Dosen</h2>

                    <div class="form-group filter-group">
                        <select id="namaDosen" name="id_dosen">
                            <option value="">NAMA DOSEN *</option>
                            @foreach ($dataJson as $pegawai)
                            <option value="{{ $pegawai->id_pegawai }}">{{ $pegawai->nama_pegawai }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="form-group filter-group">
                        <select id="kelasAjar" name="id_kelas">
                            <option value="">Kelas *</option>
                            @foreach ($dataKelas as $kelasData)
                                <option value="{{ $kelasData->id_kelas }}">{{ $kelasData->nama_kelas }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="form-group filter-group">
                        <select id="mataKuliahAjar" name="id_kurikulum">
                            <option value="">Mata Kuliah *</option>
                            @foreach ($dataKurikulum as $kurikulum)
                                <option value="{{ $kurikulum->id_kurikulum }}">{{ $kurikulum->mataKuliah->nama_mk }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn-simpan" id="simpanDosenAjar">✔ Simpan</button>
                        <button type="button" class="btn-cancel">✘ Batal</button>
                    </div>
                </div>
            </form>

            </div>
        </main>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#tahun').select2({
                width: 'resolve'
            });
        });
        $(document).ready(function() {
            $('#status').select2({
                width: 'resolve'
            });
        });
    </script>
    <script src="{{ asset('js/dosen.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
