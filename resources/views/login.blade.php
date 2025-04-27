<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login SIMPADU</title>
  <link rel="stylesheet" href="{{ asset('css/login.css') }}" />
</head>
<body>
  <div class="container">
    <div class="left-side">
      <img src="{{ asset('images/group 14.png') }}" alt="Poliban Background" class="bg-image" />
    </div>
    <div class="right-side">
      <div class="form-container">
        <img src="{{ asset('images/logo poliban.png') }}" alt="Logo" class="logo" />
        <h1>SIMPADU</h1>
        <p class="subheading">Sistem Informasi Terpadu</p>
        <h2>Selamat Datang Kembali</h2>
        <p>Silahkan masuk ke akun Anda</p>

        <!-- Form dimulai di sini -->
        <form action="{{ route('akademik') }}" method="POST">
        @csrf
          <div class="form-group">
            <label for="email">Email/NIP</label>
            <div class="input-group">
              <img src="{{ asset('images/email.png') }}" class="input-icon-email" alt="Email Icon">
              <input type="text" id="email" name="email" placeholder="Masukan Email/NIP" />
            </div>
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <div class="input-group">
              <img src="{{ asset('images/lock.png') }}" class="input-icon-pw" alt="Password Icon">
              <input type="password" id="password" name="password" placeholder="Masukan Password" />
            </div>
          </div>
          <div class="options">
            <label><input type="checkbox" name="remember" /> Ingat Saya</label>
            <a href="#">Lupa Password?</a>
          </div>
          <button type="submit">Masuk</button>
        </form>

        <p class="footer">2025 SIMPADU - Politeknik Negeri Banjarmasin</p>
      </div>
    </div>
  </div>
</body>
</html>
