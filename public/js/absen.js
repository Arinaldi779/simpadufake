// Fungsi toggle sidebar
function toggleSidebar() {
  const sidebar = document.querySelector('.sidebar');
  sidebar.classList.toggle('active');
}

// ======== Script Tambah Presensi Dosen ========
const addPresensiButton = document.querySelector('.add-presensi-dosen-button'); // Tombol "Add Presensi Dosen"
const popupOverlay = document.getElementById('presensi-dosen-popup');
const cancelButton = popupOverlay.querySelector('.btn-cancel');

// Buka popup tambah presensi dosen
addPresensiButton.addEventListener('click', () => {
  popupOverlay.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelButton.addEventListener('click', () => {
  popupOverlay.classList.remove('active');
});

// Simpan data presensi dosen
    const simpanButtonDosen = document.getElementById('simpanPresensiDosen');
    const popupDosen = document.getElementById('presensi-dosen-popup');

    simpanButtonDosen.addEventListener('click', () => {
        const nama = document.getElementById('namaDosen').value.trim();
        const prodi = document.getElementById('prodiDosen').value;
        const matkul = document.getElementById('mataKuliahDosen').value;
        const kelas = document.getElementById('kelasDosen').value;
        const semester = document.getElementById('semesterDosen').value;
        const jamMulai = document.getElementById('jamMulai').value;
        const jamSelesai = document.getElementById('jamSelesai').value;
        const status = document.getElementById('statusDosen').value;

        if (!nama || !prodi || !matkul || !kelas || !semester || !jamMulai || !jamSelesai || !status) {
            showNotification('Data Belum Terpenuhi', '#f44336');
            return;
        }

        popupDosen.classList.remove('active');
        showNotification('Presensi Dosen berhasil ditambahkan');
    });

// Tutup popup jika klik di luar konten
popupOverlay.addEventListener('click', (e) => {
  if (e.target.id === 'presensi-dosen-popup') {
    popupOverlay.classList.remove('active');
  }
});

// ======== Script Tambah Presensi Mahasiswa ========
const btnAddPresensiMhs = document.querySelector('.add-presensi-mahasiswa-button'); // Tombol "Add Presensi Mahasiswa"
const popupPresensiMhs = document.getElementById('presensi-mahasiswa-popup');
const cancelPresensiMhs = popupPresensiMhs.querySelector('.btn-cancel');


// Buka popup tambah presensi mahasiswa
btnAddPresensiMhs.addEventListener('click', () => {
  popupPresensiMhs.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelPresensiMhs.addEventListener('click', () => {
  popupPresensiMhs.classList.remove('active');
});

// Simpan data presensi mahasiswa
    const simpanMhs = document.getElementById('simpanPresensi');
    const popupMhs = document.getElementById('presensi-mahasiswa-popup');

    simpanMhs.addEventListener('click', () => {
        const nama = document.getElementById('namaMahasiswa').value.trim();
        const prodi = document.getElementById('prodi').value;
        const matkul = document.getElementById('mataKuliah').value;
        const kelas = document.getElementById('kelas').value;
        const semester = document.getElementById('semester').value;
        const status = document.getElementById('status').value;

        if (!nama || !prodi || !matkul || !kelas || !semester || !status) {
            showNotification('Data Belum Terpenuhi', '#f44336');
            return;
        }

        // Tutup popup dan tampilkan notifikasi
        popupMhs.classList.remove('active');
        showNotification('Presensi Mahasiswa berhasil ditambahkan');
    });

// Tutup popup jika klik di luar konten
popupPresensiMhs.addEventListener('click', (e) => {
  if (e.target.id === 'presensi-mahasiswa-popup') {
    popupPresensiMhs.classList.remove('active');
  }
});


// ======== Fungsi Notifikasi ========
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
