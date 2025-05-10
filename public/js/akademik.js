document.getElementById('user-icon').addEventListener('click', function () {
    const logoutForm = document.getElementById('logout-form');
    logoutForm.style.display = logoutForm.style.display === 'none' ? 'block' : 'none';
  });

    const akademikButton = document.getElementById('add-akademik-button');
    const akademikPopup = document.getElementById('akademik-popup');
    const cancelAkademik = akademikPopup.querySelector('.btn-cancel');
    const simpanAkademik = akademikPopup.querySelector('.btn-simpan');
    akademikButton.addEventListener('click', () => {
    akademikPopup.classList.add('active');
    });
    cancelAkademik.addEventListener('click', () => {
    akademikPopup.classList.remove('active');
    });
    simpanAkademik.addEventListener('click', () => {
    akademikPopup.classList.remove('active');
    showNotification('Berhasil Menambahkan Data Akademik');
    });

    akademikPopup.addEventListener('click', (e) => {
    if (e.target.id === 'akademik-popup') {
        akademikPopup.classList.remove('active');
    }
    });

    const kelasButton = document.getElementById('add-kelas-button');
    const kelasPopup = document.getElementById('kelas-popup');
    const cancelKelas = kelasPopup.querySelector('.btn-cancel');
    const simpanKelas = kelasPopup.querySelector('.btn-simpan');

    kelasButton.addEventListener('click', () => {
        kelasPopup.classList.add('active');
    });

    cancelKelas.addEventListener('click', () => {
        kelasPopup.classList.remove('active');
    });

    simpanKelas.addEventListener('click', () => {
        kelasPopup.classList.remove('active');
        showNotification('Berhasil Menambahkan Data Kelas');
    });

    kelasPopup.addEventListener('click', (e) => {
        if (e.target.id === 'kelas-popup') {
            kelasPopup.classList.remove('active');
        }
    });

    const mahasiswaButton = document.getElementById('add-mahasiswa-button');
    const mahasiswaPopup = document.getElementById('mahasiswa-popup');
    const cancelMahasiswa = mahasiswaPopup.querySelector('.btn-cancel');
    const simpanMahasiswa = mahasiswaPopup.querySelector('.btn-simpan');

    mahasiswaButton.addEventListener('click', () => {
        mahasiswaPopup.classList.add('active');
    });

    cancelMahasiswa.addEventListener('click', () => {
        mahasiswaPopup.classList.remove('active');
    });

    simpanMahasiswa.addEventListener('click', () => {
        mahasiswaPopup.classList.remove('active');
        showNotification('Berhasil Menambahkan Data Mahasiswa');
    });

    mahasiswaPopup.addEventListener('click', (e) => {
        if (e.target.id === 'mahasiswa-popup') {
            mahasiswaPopup.classList.remove('active');
        }
    });


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
