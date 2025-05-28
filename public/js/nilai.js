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


// Buka popup tambah nilai
btnAddNilai.addEventListener('click', () => {
  popupNilai.classList.add('active');
});

// Tutup popup tambah via tombol batal
cancelNilai.addEventListener('click', () => {
  popupNilai.classList.remove('active');
});

// Simpan data nilai
  const simpanButtonNilai = document.getElementById('simpanNilai');

    simpanButtonNilai.addEventListener('click', () => {
        const nama = document.getElementById('namaMahasiswaNilai').value.trim();
        const prodi = document.getElementById('prodiNilai').value;
        const matkul = document.getElementById('mataKuliahNilai').value;
        const kelas = document.getElementById('kelasNilai').value;
        const semester = document.getElementById('semesterNilai').value;
        const nilai = document.getElementById('nilaiMahasiswa').value;
        const status = document.getElementById('statusNilai').value;

        if (!nama || !prodi || !matkul || !kelas || !semester || !nilai || !status) {
            showNotification('Data Belum Terpenuhi', '#f44336');
            return;
        }

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
  