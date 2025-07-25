<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mata Kuliah</title>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="{{ asset('css/matakuliah.css') }}">
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
                <li class="active">
                    <img src="{{ asset('images/Book.png') }}" alt="MataKuliah"> MataKuliah
                </li>
                <li>
                    <a href="{{ route('dosenajar') }}" style="display: flex; align-items: center; gap: 10px; text-decoration: none; color: inherit;">
                        <img src="{{ asset('images/People.png') }}" alt="Dosen Ajar"> Dosen Ajar
                    </a>
                </li>


                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <div class="breadcrumb-line-inline">
                <a href="{{ url('prodi') }}" class="grey-text">Dashboard</a>  &gt; <strong>Mata Kuliah</strong>
            </div>
            <br>
            <div class="header-flex">
                <h2 class="page-title">Mata Kuliah</h2>
                <button class="add-button">+ Tambah Mata Kuliah</button>
            </div>

            <form method="GET" action="{{ route('matakuliah') }}">
            <div class="filter-box">
                <div class="filter-group">
                    <label for="mk">Nama</label>
                    <select id="mk" name="mk" class="select2">
                        <option value="">Semua Mata Kuliah</option>
                    @foreach ($data as $dataMk)
                        <option value="{{ $dataMk->nama_mk }}" {{ request('mk') == $dataMk->nama_mk ? 'selected' : '' }}>
                        {{ $dataMk->nama_mk }}
                        </option>
                    @endforeach
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status">Kode MK</label>
                    <select id="kodeMk" name="kodeMk" class="select2">
                        <option value="">Semua Tahun</option>
                    @foreach ($data as $dataMk)
                        <option value="{{ $dataMk->kode_mk }}" {{ request('kodeMk') == $dataMk->kode_mk ? 'selected' : '' }}>
                        {{ $dataMk->kode_mk }}
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
                            <th>KODE MATA KULIAH</th>
                            <th>NAMA MATA KULIAH</th>
                            <th>SKS</th>
                            <th>AKSI</th>
                        </tr> 
                    </thead>
                    <tbody>

                        @foreach ($data as $dataMk)
                        <tr>
                            <td>{{ $dataMk->kode_mk }}</td>
                            <td>{{ $dataMk->nama_mk }}</td>
                            <td>{{ $dataMk->sks }}</td>
                            <td><a href="{{ route('editmk') }}" class="edit-btn" style="text-decoration: none; display: inline-block; color: #474747;">Edit</a></td>

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
            <form action="{{ route('matakuliah.create') }}" method="POST">
            @csrf
            <div class="popup-overlay" id="popup">
    <div class="popup-content">

        <h2>Tambah MataKuliah</h2>

        <!-- Tidak pakai form karena JS tidak submit otomatis -->
        <div class="form-group">
            <input type="text" name="kode_mk" placeholder="Kode Mata Kuliah *">
        </div>

        <div class="form-group">
            <input type="text" name="nama_mk" placeholder="Nama Mata Kuliah *">
        </div>

        <div class="form-group filter-group">
            <select id="tahunakademik" name="id_thn_ak">
                <option value="">Pilih Tahun Akademik *</option>
                @foreach ($dataThnAk as $dataThn)
                <option value="{{ $dataThn->id_thn_ak }}">{{ $dataThn->nama_thn_ak }}</option>
                @endforeach
            </select>
        </div>

        <div class="form-group">
            <input type="text" name="sks" placeholder="SKS *">
        </div>

        <div class="form-group">
            <input type="text" name="jam" placeholder="Jam *">
        </div>

        <div class="button-group">
            <!-- ID disamakan agar dikenali JS -->
            <button type="button" class="btn-simpan" id="simpanButtonMk">✔ Simpan</button>
            <button type="button" class="btn-cancel">✘ Batal</button>
        </div>
    </div>
</div>

        </form>
        </main>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#mk').select2({
                width: 'resolve'
            });
        });
        $(document).ready(function() {
            $('#kodeMk').select2({
                width: 'resolve'
            });
        });
    </script>
    <script src="{{ asset('js/matkul.js') }}"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>
