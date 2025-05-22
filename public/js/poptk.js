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
// Simpan data tambah (validasi input)
    simpanButton.addEventListener('click', (e) => {
      const namaKelas = document.getElementById("nama_kelas").value.trim();
      const prodi = document.getElementById("prodi").value;
      const tahunAkademik = document.getElementById("tahun_akademik").value;

      if (!namaKelas || !prodi || !tahunAkademik) {
        e.preventDefault();
        showNotification("Data Belum Terpenuhi!", "#f44336");
        return;
      }

      popupOverlay.classList.remove('active');
      showNotification("Berhasil Menambahkan Data");
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


    $(document).ready(function() {
        $('.select2').select2({
            placeholder: "Pilih Program Studi",
            allowClear: true
        });
    });