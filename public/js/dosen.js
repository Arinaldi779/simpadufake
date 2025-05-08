    function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('active');
  }
  
  
  // Assign Dosen
  const assignButton = document.getElementById('add-button');
  const assignPopup = document.getElementById('add-popup');
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
  showNotification('Berhasil Tambah Dosen');
  });

  // Tutup popup jika klik luar konten
  assignPopup.addEventListener('click', (e) => {
  if (e.target.id === 'assign-popup') {
      assignPopup.classList.remove('active');
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
  