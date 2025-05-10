// Fungsi toggle sidebar
function toggleSidebar() {
  const sidebar = document.querySelector('.sidebar');
  sidebar.classList.toggle('active');
}

// ======== Script Tambah KHS ========
const addKhsButton = document.querySelector('.add-khs-button'); // Tombol "Add KHS"
const popupKhs = document.getElementById('khs-popup');
const cancelKhs = popupKhs.querySelector('.btn-cancel');
const simpanKhs = popupKhs.querySelector('.btn-simpan');

// Buka popup tambah KHS
addKhsButton.addEventListener('click', () => {
  popupKhs.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelKhs.addEventListener('click', () => {
  popupKhs.classList.remove('active');
});

// Simpan data KHS
simpanKhs.addEventListener('click', () => {
  popupKhs.classList.remove('active');
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
const simpanKrs = popupKrs.querySelector('.btn-simpan');

// Buka popup tambah KRS
addKrsButton.addEventListener('click', () => {
  popupKrs.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelKrs.addEventListener('click', () => {
  popupKrs.classList.remove('active');
});

// Simpan data KRS
simpanKrs.addEventListener('click', () => {
  popupKrs.classList.remove('active');
  showNotification('KRS berhasil ditambahkan');
});

// Tutup popup jika klik di luar konten
popupKrs.addEventListener('click', (e) => {
  if (e.target.id === 'krs-popup') {
    popupKrs.classList.remove('active');
  }
});

// ======== Fungsi Notifikasi ========
function showNotification(message) {
  const notif = document.createElement('div');
  notif.innerText = message;
  notif.style.position = 'fixed';
  notif.style.bottom = '30px';
  notif.style.left = '50%';
  notif.style.transform = 'translateX(-50%)';
  notif.style.backgroundColor = '#4CAF50';
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
