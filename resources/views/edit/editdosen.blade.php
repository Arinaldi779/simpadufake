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
        <div class="form-akademik">

            <div class="form-group">
                <label for="status">Nama Dosen</label>
                <select id="status" class="status-select">
                    <option>Nama Dosen *</option>
                </select>
            </div>
            <div class="form-group">
                <label for="status">Program Studi</label>
                <select id="status" class="status-select">
                    <option>Program Studi *</option>
                </select>
            </div>
            <div class="form-group">
                <label for="status">Mata Kuliah</label>
                <select id="status" class="status-select">
                    <option>Mata Kuliah *</option>
                </select>
            </div>
            <div class="form-group">
                <label for="status">Kelas</label>
                <select id="status" class="status-select">
                    <option>Kelas *</option>
                </select>
            </div>
            <div class="form-group">
                <label for="status">Semester</label>
                <select id="status" class="status-select">
                    <option>Semester *</option>
                </select>
            </div>

            <div class="form-actions">
                <a href="{{ route('dosenajar') }}" class="btn-simpan" style="text-decoration: none; display: inline-block;">Simpan Perubahan</a>
                <a href="{{ route('dosenajar') }}" class="btn-batal" style="text-decoration: none; display: inline-block;">Batalkan</a>
            </div>
        </div>

    </div>

    <script src="{{ asset('js/edit.js') }}"></script>
</body>
</html>