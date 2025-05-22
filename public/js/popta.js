// Fungsi toggle sidebar
function toggleSidebar() {
  const sidebar = document.querySelector('.sidebar');
  sidebar.classList.toggle('active');
}

function toggleStatus(button, id) {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  fetch(`/tahun-akademik/toggle-status/${id}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken
    },
    body: JSON.stringify({})
  })
  .then(response => response.json())
  .then(data => {
    const newStatus = data.status; // 'Y' atau 'T'
    button.textContent = newStatus === 'Y' ? 'Aktif' : 'Tidak Aktif';

    button.classList.remove('active', 'inactive');

    if (newStatus === 'Y') {
      button.classList.add('active');
    } else {
      button.classList.add('inactive');
    }

    console.log('Class tombol sekarang:', button.className);
  })
  .catch(error => {
    console.error('Gagal memperbarui status:', error);
  });
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

const formTambah = popupOverlay.querySelector('form'); // form di dalam #popup
const simpanTambah = popupOverlay.querySelector('.btn-simpan');

simpanTambah.addEventListener('click', function(e) {
  e.preventDefault(); // cegah submit dulu

  // Ambil elemen input/select yang wajib diisi
  const idThnAk = formTambah.querySelector('input[name="id_thn_ak"]');
  const namaThnAk = formTambah.querySelector('input[name="nama_thn_ak"]');
  const smt = formTambah.querySelector('select[name="smt"]');
  const tglAwal = formTambah.querySelector('input[name="tgl_awal_kuliah"]');
  const tglAkhir = formTambah.querySelector('input[name="tgl_akhir_kuliah"]');
  const status = formTambah.querySelector('select[name="status"]');

  // Reset border merah dulu
  [idThnAk, namaThnAk, smt, tglAwal, tglAkhir, status].forEach(el => {
    el.style.borderColor = '';
  });

  let valid = true;

  // Cek tiap input/select
  if (!idThnAk.value.trim()) {
    idThnAk.style.borderColor = 'red';
    valid = false;
  }
  if (!namaThnAk.value.trim()) {
    namaThnAk.style.borderColor = 'red';
    valid = false;
  }
  if (!smt.value) {
    smt.style.borderColor = 'red';
    valid = false;
  }
  if (!tglAwal.value) {
    tglAwal.style.borderColor = 'red';
    valid = false;
  }
  if (!tglAkhir.value) {
    tglAkhir.style.borderColor = 'red';
    valid = false;
  }
  if (!status.value) {
    status.style.borderColor = 'red';
    valid = false;
  }

  if (!valid) {
    showNotification('Data Belum Terpenuhi!', '#f44336'); // merah
    return; // jangan submit
  }

  // Jika valid, submit form dan tutup popup serta notif sukses
  formTambah.submit();
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

  setTimeout(() => {
    notif.style.opacity = '1';
    notif.style.bottom = '50px';
  }, 10);

  setTimeout(() => {
    notif.style.opacity = '0';
    notif.style.bottom = '30px';
    setTimeout(() => {
      notif.remove();
    }, 500);
  }, 3000);
}

