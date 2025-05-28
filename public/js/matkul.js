// Fungsi toggle sidebar
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('active');
  }
  
  // ======== Script Tambah Data ========
  const addButton = document.querySelector('.add-button');
  const popupOverlay = document.getElementById('popup');
  const cancelButton = popupOverlay.querySelector('.btn-cancel');
  const simpanButton = popupOverlay.querySelector('.btn-simpan');
  
  // Buka popup tambah
  addButton.addEventListener('click', () => {
    popupOverlay.classList.add('active');
  });
  
  // Tutup popup tambah via tombol cancel
  cancelButton.addEventListener('click', () => {
    popupOverlay.classList.remove('active');
  });
  
  // Simpan data tambah
 simpanButtonMk.addEventListener('click', (e) => {
        const kode = document.querySelector('input[name="kode_mk"]').value.trim();
        const nama = document.querySelector('input[name="nama_mk"]').value.trim();
        const tahun = document.querySelector('select[name="id_thn_ak"]').value;
        const sks = document.querySelector('input[name="sks"]').value.trim();
        const jam = document.querySelector('input[name="jam"]').value.trim();

        if (!kode || !nama || !tahun || !sks || !jam) {
            showNotification("Data Belum Terpenuhi!", "#f44336");
            return;
        }

        // Kirim form (gunakan form.submit jika form tidak pakai tombol submit langsung)
        // Contoh kalau kamu ingin submit manual:
        // document.querySelector('form').submit();

        popupOverlay.classList.remove('active');
        showNotification('Berhasil Menambahkan Data');
    });
  
  // Tutup popup tambah kalau klik di luar konten
  popupOverlay.addEventListener('click', (e) => {
    if (e.target.id === 'popup') {
        popupOverlay.classList.remove('active');
    }
  });
  
  // ======== Script Edit Data ========
  const popupEdit = document.getElementById('popupedit');
  const cancelEditButton = popupEdit.querySelector('.btn-cancel');
  const simpanEditButton = popupEdit.querySelector('.btn-simpan');
  
  // Buka popup edit saat klik tombol Edit
  document.querySelectorAll('.edit-btn').forEach(button => {
    button.addEventListener('click', function() {
        popupEdit.classList.add('show');
    });
  });
  
  // Tutup popup edit via tombol cancel
  cancelEditButton.addEventListener('click', function() {
    popupEdit.classList.remove('show');
  });
  
  // Simpan data edit
  simpanEditButton.addEventListener('click', function() {
    popupEdit.classList.remove('show');
    showNotification('Berhasil Mengedit Data');
  });
  
  // Tutup popup edit kalau klik di luar konten
  popupEdit.addEventListener('click', function(e) {
    if (e.target.id === 'popupedit') {
        popupEdit.classList.remove('show');
    }
  });
  
  // ======== Fungsi Notifikasi ========
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