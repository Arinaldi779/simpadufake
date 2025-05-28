// Fungsi toggle sidebar
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('active');
  }
  
  // ======== Script Tambah Data ========
  const addButton = document.querySelector('.add-button');
  const popupOverlay = document.getElementById('popup');
  const cancelButton = popupOverlay.querySelector('.btn-cancel');
  
  // Buka popup tambah
  addButton.addEventListener('click', () => {
    popupOverlay.classList.add('active');
  });
  
  // Tutup popup tambah via tombol cancel
  cancelButton.addEventListener('click', () => {
    popupOverlay.classList.remove('active');
  });

  
  // Simpan data tambah
    const simpanButton = document.getElementById('simpanDosenAjar');

    simpanButton.addEventListener('click', () => {
        const prodi = document.getElementById('programStudi').value;
        const kelas = document.getElementById('kelasAjar').value;
        const matkul = document.getElementById('mataKuliahAjar').value;

        if (!prodi || !kelas || !matkul) {
            showNotification('Data Belum Terpenuhi', '#f44336');
            return;
        }

        popupOverlay.classList.remove('active');
        showNotification('Data Dosen Ajar berhasil ditambahkan');
    });
  
  // Tutup popup tambah kalau klik di luar konten
  popupOverlay.addEventListener('click', (e) => {
    if (e.target.id === 'popup') {
        popupOverlay.classList.remove('active');
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