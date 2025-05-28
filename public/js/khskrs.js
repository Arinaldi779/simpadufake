// Fungsi toggle sidebar
function toggleSidebar() {
  const sidebar = document.querySelector('.sidebar');
  sidebar.classList.toggle('active');
}

// ======== Script Tambah KHS ========
const addKhsButton = document.querySelector('.add-khs-button'); // Tombol "Add KHS"
const popupKhs = document.getElementById('khs-popup');
const cancelKhs = popupKhs.querySelector('.btn-cancel');

// Buka popup tambah KHS
addKhsButton.addEventListener('click', () => {
  popupKhs.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelKhs.addEventListener('click', () => {
  popupKhs.classList.remove('active');
});

// Simpan data KHS
    const simpanButtonKHS = document.getElementById('simpanKHS');
    const popupKHS = document.getElementById('khs-popup');

    simpanButtonKHS.addEventListener('click', () => {
        const matakuliah = document.getElementById('namaMatakuliahKHS').value.trim();
        const nilai = document.getElementById('nilaiKHS').value.trim();
        const dosen = document.getElementById('namaDosenKHS').value.trim();
        const status = document.getElementById('statusKHS').value;

        if (!matakuliah || !nilai || !dosen || !status) {
            showNotification('Data Belum Terpenuhi', '#f44336');
            return;
        }

        popupKHS.classList.remove('active');
        showNotification('KHS berhasil ditambahkan');
    });

// Tutup popup jika klik di luar konten
popupKhs.addEventListener('click', (e) => {
  if (e.target.id === 'khs-popup') {
    popupKhs.classList.remove('active');
  }
});

// ======== Script Tambah KRS ========
const addKrsButton = document.querySelector('.add-krs-button'); // Tombol "Add KRS"
const popupKrs = document.getElementById('krs-popup');
const cancelKrs = popupKrs.querySelector('.btn-cancel');

// Buka popup tambah KRS
addKrsButton.addEventListener('click', () => {
  popupKrs.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelKrs.addEventListener('click', () => {
  popupKrs.classList.remove('active');
});

// Simpan data KRS
    const simpanButtonKRS = document.getElementById('simpanKRS');
    const popupKRS = document.getElementById('krs-popup');

    simpanButtonKRS.addEventListener('click', () => {
        const nim = document.getElementById('nimKRS').value.trim();
        const matkul = document.getElementById('namaMatkulKRS').value.trim();
        const sks = document.getElementById('sksKRS').value.trim();
        const nilaiNum = document.getElementById('nilaiNumerikKRS').value.trim();
        const nilaiHuruf = document.getElementById('nilaiHurufKRS').value.trim();
        const bobot = document.getElementById('bobotNilaiKRS').value;

        if (!nim || !matkul || !sks || !nilaiNum || !nilaiHuruf || !bobot) {
            showNotification('Data Belum Terpenuhi', '#f44336');
            return;
        }

        popupKRS.classList.remove('active');
        showNotification('KRS berhasil ditambahkan');
    });

// Tutup popup jika klik di luar konten
popupKrs.addEventListener('click', (e) => {
  if (e.target.id === 'krs-popup') {
    popupKrs.classList.remove('active');
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
