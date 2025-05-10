// Fungsi toggle sidebar
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('active');
  }

  
  
  // ======== Script Tambah Data ========
  const addButton = document.querySelector('.add-button');
  const dsnButton = document.querySelector('.dsn-button');
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
  simpanButton.addEventListener('click', () => {
    popupOverlay.classList.remove('active');
    showNotification('Berhasil Menambahkan Data');
  });
  
  // Tutup popup tambah kalau klik di luar konten
  popupOverlay.addEventListener('click', (e) => {
    if (e.target.id === 'popup') {
        popupOverlay.classList.remove('active');
    }
  });
  

  // Assign Dosen
    const assignButton = document.getElementById('assign-dosen-button');
    const assignPopup = document.getElementById('assign-popup');
    const cancelAssign = assignPopup.querySelector('.btn-cancel');
    const simpanAssign = assignPopup.querySelector('.btn-simpan');

    // Buka popup assign dosen
    assignButton.addEventListener('click', () => {
    assignPopup.classList.add('active');
    });

    // Tutup popup assign dosen via tombol cancel
    cancelAssign.addEventListener('click', () => {
    assignPopup.classList.remove('active');
    });

    // Simpan assign dosen
    simpanAssign.addEventListener('click', () => {
    assignPopup.classList.remove('active');
    showNotification('Berhasil Assign Dosen');
    });

    // Tutup popup jika klik luar konten
    assignPopup.addEventListener('click', (e) => {
    if (e.target.id === 'assign-popup') {
        assignPopup.classList.remove('active');
    }
    });

    // Presensi
    const presensiButton = document.getElementById('add-presensi-button');
    const presensiPopup = document.getElementById('presensi-popup');
    const cancelPresensi = presensiPopup.querySelector('.btn-cancel');
    const simpanPresensi = presensiPopup.querySelector('.btn-simpan');

    // Buka popup presensi
    presensiButton.addEventListener('click', () => {
        presensiPopup.classList.add('active');
    });

    // Tutup popup presensi via tombol cancel
    cancelPresensi.addEventListener('click', () => {
        presensiPopup.classList.remove('active');
    });

    // Simpan presensi
    simpanPresensi.addEventListener('click', () => {
        presensiPopup.classList.remove('active');
        showNotification('Berhasil Menyimpan Presensi');
    });

    // Tutup popup jika klik luar konten
    presensiPopup.addEventListener('click', (e) => {
        if (e.target.id === 'presensi-popup') {
            presensiPopup.classList.remove('active');
        }
    });

    const addPresensiDosenButton = document.getElementById('add-presensi-dosen-button');
    const presensiDosenPopup = document.getElementById('presensi-dosen-popup');
    const cancelPresensiDosen = presensiDosenPopup.querySelector('.btn-cancel');
    const simpanPresensiDosen = presensiDosenPopup.querySelector('.btn-simpan');

    // Buka popup untuk menambahkan presensi dosen
    addPresensiDosenButton.addEventListener('click', () => {
        presensiDosenPopup.classList.add('active');
    });

    // Tutup popup presensi dosen via tombol cancel
    cancelPresensiDosen.addEventListener('click', () => {
        presensiDosenPopup.classList.remove('active');
    });

    // Simpan presensi dosen
    simpanPresensiDosen.addEventListener('click', () => {
        presensiDosenPopup.classList.remove('active');
        showNotification('Berhasil Menyimpan Presensi Dosen');
    });

    // Tutup popup jika klik luar konten
    presensiDosenPopup.addEventListener('click', (e) => {
        if (e.target.id === 'presensi-dosen-popup') {
            presensiDosenPopup.classList.remove('active');
        }
    });

    const addPresensiMahasiswaButton = document.getElementById('add-presensi-mahasiswa-button');
const presensiMahasiswaPopup = document.getElementById('presensi-mahasiswa-popup');
const cancelPresensiMahasiswa = presensiMahasiswaPopup.querySelector('.btn-cancel');
const simpanPresensiMahasiswa = presensiMahasiswaPopup.querySelector('.btn-simpan');

// Buka popup untuk menambahkan presensi mahasiswa
addPresensiMahasiswaButton.addEventListener('click', () => {
    presensiMahasiswaPopup.classList.add('active');
});

// Tutup popup presensi mahasiswa via tombol cancel
cancelPresensiMahasiswa.addEventListener('click', () => {
    presensiMahasiswaPopup.classList.remove('active');
});

// Simpan presensi mahasiswa
simpanPresensiMahasiswa.addEventListener('click', () => {
    presensiMahasiswaPopup.classList.remove('active');
    showNotification('Berhasil Menyimpan Presensi Mahasiswa');
});

// Tutup popup jika klik luar konten
presensiMahasiswaPopup.addEventListener('click', (e) => {
    if (e.target.id === 'presensi-mahasiswa-popup') {
        presensiMahasiswaPopup.classList.remove('active');
    }
});



    // Tambah Kurikulum (ID: add-kurikulum-button)
    const kurikulumButton = document.getElementById('add-kurikulum-button');
    const kurikulumPopup = document.getElementById('kurikulum-popup');
    const cancelKurikulum = kurikulumPopup.querySelector('.btn-cancel');
    const simpanKurikulum = kurikulumPopup.querySelector('.btn-simpan');

    // Buka popup tambah kurikulum
    kurikulumButton.addEventListener('click', () => {
    kurikulumPopup.classList.add('active');
    });

    // Tutup popup kurikulum via tombol cancel
    cancelKurikulum.addEventListener('click', () => {
    kurikulumPopup.classList.remove('active');
    });

    // Simpan tambah kurikulum
    simpanKurikulum.addEventListener('click', () => {
    kurikulumPopup.classList.remove('active');
    showNotification('Berhasil Menambahkan Kurikulum');
    });

    // Tutup popup jika klik luar konten
    kurikulumPopup.addEventListener('click', (e) => {
        if (e.target.id === 'kurikulum-popup') {
            kurikulumPopup.classList.remove('active');
        }
    });
    

    // Tambah Nilai (ID: add-nilai-button)
const nilaiButton = document.getElementById('add-nilai-button');
const nilaiPopup = document.getElementById('nilai-popup');
const cancelNilai = nilaiPopup.querySelector('.btn-cancel');
const simpanNilai = nilaiPopup.querySelector('.btn-simpan');

nilaiButton.addEventListener('click', () => {
    nilaiPopup.classList.add('active');
});

cancelNilai.addEventListener('click', () => {
    nilaiPopup.classList.remove('active');
});

simpanNilai.addEventListener('click', () => {
    nilaiPopup.classList.remove('active');
    showNotification('Berhasil Menambahkan Nilai');
});

nilaiPopup.addEventListener('click', (e) => {
    if (e.target.id === 'nilai-popup') {
        nilaiPopup.classList.remove('active');
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
  
  document.getElementById('user-icon').addEventListener('click', function () {
    const logoutForm = document.getElementById('logout-form');
    logoutForm.style.display = logoutForm.style.display === 'none' ? 'block' : 'none';
  });