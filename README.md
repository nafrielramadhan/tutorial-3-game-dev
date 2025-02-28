## 🎮 Deskripsi Proyek

Proyek ini adalah tutorial 3 Game Dev, saya belajar untuk membuat animasi sprite 2D.

## 📌 Animasi yang Digunakan

1. **stand** → Animasi saat karakter diam
2. **walk** → Animasi saat karakter berjalan
3. **jump** → Animasi saat karakter melakukan lompatan pertama
4. **double_jump** → Animasi saat karakter melakukan lompatan kedua (double jump)
5. **fall** → Animasi saat karakter sedang jatuh
6. **dash** → Animasi saat karakter melakukan dash setelah double tap
7. **crouch** → Animasi saat karakter jongkok (ditekan tombol bawah di tanah)

## 💻 Implementasi per-Animasi

**Implementasi Stand:**

Animasi 'stand' diputar saat karakter tidak bergerak dan tidak dalam status lain seperti lompat atau dash. Dalam kode, ini ditentukan ketika `velocity.x == 0` dan karakter berada di tanah.

**Implementasi Walk:**

Animasi 'walk' diputar saat karakter bergerak ke kiri atau kanan. Saat `velocity.x != 0` dan karakter berada di tanah, animasi ini akan dijalankan. Karakter juga akan membalik (flip) sprite sesuai arah gerakan.

**Implementasi Jump:**

Animasi 'jump' diputar ketika karakter pertama kali melompat. Ini terjadi saat `Input.is_action_just_pressed("ui_up")` dan karakter belum mencapai batas lompatan maksimal.

**Implementasi Double Jump:**

Animasi 'double_jump' diputar ketika karakter melompat untuk kedua kalinya sebelum menyentuh tanah. Ini terjadi saat `jump_count == 2` dalam kode.

**Implementasi Dash:**

Animasi 'dash' diputar saat karakter melakukan dash setelah menekan tombol arah dua kali dalam waktu singkat. Dash berlangsung selama `dash_duration` sebelum kembali ke status normal.

**Implementasi Fall:**

Animasi 'fall' diputar saat karakter sedang turun di udara, setelah melompat atau berjalan dari tepi platform. Ini terjadi ketika `velocity.y > 0` dan karakter tidak menyentuh tanah.

**Implementasi Crouch:**

Animasi 'crouch' diputar ketika karakter berada di tanah dan tombol bawah ditekan (`Input.is_action_pressed("ui_down")`). Saat dalam keadaan jongkok, karakter tidak bisa berjalan atau melompat.
