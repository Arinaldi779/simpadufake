    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Akademik</title>
        <link rel="stylesheet" href="{{ asset('css/edit.css') }}">
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
            <img src="{{ asset('images/Test Account.png') }}" alt="User" class="logo-icon" id="user-icon" style="cursor: pointer;" />
            <form id="logout-form" method="POST" action="{{ route('logout') }}" style="display: none;">
            @csrf
            <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>
        </header>

        <div class="container">
            <form action="{{ route('thnAk.update', $data->id_thn_ak) }}" method="POST">
                @csrf   
                @method('PUT')
            
                <div class="form-akademik">
                    <div class="form-group">
                        <label for="tahun-akademik">Tahun Akademik</label>
                        <input type="text" id="tahun-akademik" name="nama_thn_ak" 
                               class="input-tahun-akademik" 
                               value="{{ old('nama_thn_ak', $data->nama_thn_ak) }}">
                    </div>
            
                    <div class="form-group tanggal">
                        <div class="tanggal-range">
                            <div>
                                <label>Start Date:</label>
                                <input type="date" name="tgl_awal_kuliah" 
                                       value="{{ old('tgl_awal_kuliah', $data->tgl_awal_kuliah?->format('Y-m-d')) }}">
                            </div>
                            <div>
                                <label>End Date:</label>
                                <input type="date" name="tgl_akhir_kuliah" 
                                       value="{{ old('tgl_akhir_kuliah', $data->tgl_akhir_kuliah?->format('Y-m-d')) }}">
                            </div>
                        </div>
                    </div>
            
                    <div class="form-group">
                        <label for="aktif">Status</label>
                        <select id="aktif" class="status-select" name="aktif">
                            <option value="Y" {{ $data->aktif == 'Y' ? 'selected' : '' }}>Aktif</option>
                            <option value="T" {{ $data->aktif == 'T' ? 'selected' : '' }}>Tidak Aktif</option>
                        </select>
                    </div>
            
                    <div class="form-actions">
                        <button type="submit" class="btn-simpan">Simpan Perubahan</button>
                        <a href="{{ route('tahunakademik') }}" class="btn-batal" style="text-decoration: none; display: inline-block;">Batalkan</a>
                    </div>
                </div>
            </form>
            

        </div>

        <script src="{{ asset('js/edit.js') }}"></script>
    </body>
    </html>