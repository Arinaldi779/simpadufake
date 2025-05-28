document.getElementById('user-icon').addEventListener('click', function () {
    const logoutForm = document.getElementById('logout-form');
    logoutForm.style.display = logoutForm.style.display === 'none' ? 'block' : 'none';
  });

// ======== Popup Tambah Tahun Akademik ========
const popupAkademik = document.getElementById('akademik-popup');
const addAkademikBtn = document.getElementById('add-akademik-button');
const simpanAkademikBtn = popupAkademik.querySelector('.btn-simpan-akademik');
const cancelAkademikBtn = popupAkademik.querySelector('.btn-cancel-akademik');
const formAkademik = document.getElementById('form-akademik');

// Tampilkan popup saat tombol "Buat Tahun Akademik" diklik
addAkademikBtn.addEventListener('click', () => {
  popupAkademik.classList.add('active');
});

// Tutup popup saat klik tombol "Batal"
cancelAkademikBtn.addEventListener('click', () => {
  popupAkademik.classList.remove('active');
});

// Validasi input sebelum submit
simpanAkademikBtn.addEventListener('click', function (e) {
  const idThnAk = formAkademik.querySelector('input[name="id_thn_ak"]').value.trim();
  const namaThnAk = formAkademik.querySelector('input[name="nama_thn_ak"]').value.trim();
  const catatan = formAkademik.querySelector('input[name="catatan"]').value.trim();
  const tglAwal = formAkademik.querySelector('input[name="tgl_awal_kuliah"]').value.trim();
  const tglAkhir = formAkademik.querySelector('input[name="tgl_akhir_kuliah"]').value.trim();
  const aktif = formAkademik.querySelector('select[name="aktif"]').value;

  if (!idThnAk || !namaThnAk || !catatan || !tglAwal || !tglAkhir || !aktif) {
    e.preventDefault();
    showNotification('Data Belum Terpenuhi!', '#f44336');
    return;
  }

  formAkademik.submit();
});


    // ======== Popup Tambah Kelas ========
const popupKelas = document.getElementById('kelas-popup');
const btnAddKelas = document.getElementById('add-kelas-button');
const btnSimpanKelas = popupKelas.querySelector('.btn-simpan-kelas');
const btnCancelKelas = popupKelas.querySelector('.btn-cancel-kelas');

// Tampilkan popup kelas
btnAddKelas.addEventListener('click', () => {
  popupKelas.classList.add('active');
});

// Tutup popup kelas
btnCancelKelas.addEventListener('click', () => {
  popupKelas.classList.remove('active');
});

// Validasi dan simpan kelas
btnSimpanKelas.addEventListener('click', (e) => {
  e.preventDefault(); // <--- ini penting
  const namaKelas = popupKelas.querySelector('input[type="text"]').value.trim();
  const prodi = popupKelas.querySelector('#prodi').value;
  const semester = popupKelas.querySelector('#semester').value;

  if (!namaKelas || !prodi || !semester || prodi === "Program Studi *" || semester === "Angkatan *") {
    showNotification("Data Belum Terpenuhi!", "#f44336");
    return;
  }

  popupKelas.classList.remove('active');
  showNotification("Berhasil Menambahkan Kelas");
});

// ======== Popup Tambah Mahasiswa ========
const popupMahasiswa = document.getElementById('mahasiswa-popup');
const btnAddMahasiswa = document.getElementById('add-mahasiswa-button');
const btnSimpanMahasiswa = popupMahasiswa.querySelector('.btn-simpan-mahasiswa');
const btnCancelMahasiswa = popupMahasiswa.querySelector('.btn-cancel-mahasiswa');

// Tampilkan popup mahasiswa
btnAddMahasiswa.addEventListener('click', () => {
  popupMahasiswa.classList.add('active');
});

// Tutup popup mahasiswa
btnCancelMahasiswa.addEventListener('click', () => {
});

// Validasi dan simpan mahasiswa
btnSimpanMahasiswa.addEventListener('click', () => {
  const nim = popupMahasiswa.querySelector('input[placeholder="NIM *"]').value.trim();
  const nama = popupMahasiswa.querySelector('input[placeholder="Nama Mahasiswa *"]').value.trim();
  const status = popupMahasiswa.querySelector('select').value;

  if (!nim || !nama || !status || status === "Status *") {
    showNotification("Data Belum Terpenuhi!", "#f44336");
    return;
  }

  popupMahasiswa.classList.remove('active');
  showNotification("Berhasil Menambahkan Mahasiswa");
});

    function showNotification(message, color = '#4CAF50') {
  const notif = document.createElement('div');
  notif.innerText = message;
  notif.style.position = 'fixed';
  notif.style.bottom = '30px';
  notif.style.left = '50%';
  notif.style.transform = 'translateX(-50%)';
  notif.style.backgroundColor = color;
  notif.style.color = 'white';
  notif.style.padding = '12px 24px';
  notif.style.borderRadius = '8px';
  notif.style.fontSize = '16px';
  notif.style.boxShadow = '0 4px 8px rgba(0,0,0,0.2)';
  notif.style.zIndex = '10000';
  notif.style.opacity = '0';
  notif.style.transition = 'opacity 0.5s, bottom 0.5s';

  document.body.appendChild(notif);

  // Animasi masuk
  setTimeout(() => {
    notif.style.opacity = '1';
    notif.style.bottom = '50px';
  }, 10);

  // Hilang setelah 3 detik
  setTimeout(() => {
    notif.style.opacity = '0';
    notif.style.bottom = '30px';
    setTimeout(() => {
      notif.remove();
    }, 500);
  }, 3000);
}