// Fungsi toggle sidebar
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('active');
  }
  
  // ======== Script Tambah Data ========
// ======== Script Tambah Nilai ========
const btnAddNilai = document.querySelector('.add-nilai-button'); // Tombol "Add Nilai"
const popupNilai = document.getElementById('nilai-popup');
const cancelNilai = popupNilai.querySelector('.btn-cancel');
const simpanNilai = popupNilai.querySelector('.btn-simpan');

// Buka popup tambah nilai
btnAddNilai.addEventListener('click', () => {
  popupNilai.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelNilai.addEventListener('click', () => {
  popupNilai.classList.remove('active');
});

// Simpan data nilai
simpanNilai.addEventListener('click', () => {
  popupNilai.classList.remove('active');
  showNotification('Nilai berhasil ditambahkan');
});

// Tutup popup jika klik di luar konten
popupNilai.addEventListener('click', (e) => {
  if (e.target.id === 'nilai-popup') {
    popupNilai.classList.remove('active');
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
  