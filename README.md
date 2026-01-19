# Gayong Kebangsaan - Backend Scaffold (MySQL, Decimal)

Ini adalah scaffold backend minimal untuk "Gayong Kebangsaan App" menggunakan Node.js + Express + Prisma (MySQL).

Perubahan: Prisma telah dikonfigurasikan untuk MySQL (Decimal untuk amaun). Sila pastikan MySQL server anda aktif dan kredensial betul.

Keperluan:
- Node.js >= 18
- MySQL (local atau hosted)
- npm atau pnpm
- (Opsional) Docker untuk MySQL

Langkah pemasangan (penuh):

1. Clone repo atau letakkan fail-fail scaffold ke server:
   - contoh: `/home/IymzDD8rFQXm1KZI/AppGK` (ikut maklumat server anda)

2. Salin `.env.example` menjadi `.env` dan kemaskini `DATABASE_URL`.
   - Format contoh:
     DATABASE_URL="mysql://DB_USER:DB_PASSWORD@HOST:3306/DATABASE_NAME"
   - Jika kata laluan mengandungi '@' atau watak khas, URL-encode: '@' -> '%40'

3. Pasang dependency:
   - npm ci

4. Generate Prisma client:
   - npx prisma generate

5. Jalankan migration (production):
   - npx prisma migrate deploy
   - (Untuk development anda boleh gunakan `npx prisma migrate dev --name init`)

6. Seed jadual yuran bengkung dari CSV:
   - npm run seed
   - Skrip seed membaca `jadual pembahagian yuran bengkung.csv` dari root projek.

7. Jalankan server (development):
   - npm run dev
   - Server lalai: `http://localhost:4000`
   - Endpoint contoh: `GET /api/jadual-yuran-bengkung`

Arahan automatik (skrip):
- run_migrate_seed.sh disediakan dan menggunakan PROJECT_ROOT default:
  /home/IymzDD8rFQXm1KZI/AppGK
- Untuk jalankan secara automatik:
  chmod +x run_migrate_seed.sh
  ./run_migrate_seed.sh

Perhatian:
- Jangan commit credential sebenar (.env) ke repo awam.
- Jika perlu tukar PROJECT_ROOT, edit run_migrate_seed.sh atau setkan env APP_WEBROOT sebelum menjalankan skrip.
- Semua amaun disimpan sebagai DECIMAL(10,2). Seed membaca CSV dan menulis nilai sebagai string dua perpuluhan (contoh "4.00", "15.50").

Jika mahu saya teruskan dengan:
- Menyediakan patch/PR (saya sediakan arahan di bawah untuk push & buat PR)
- Membantu langkah demi langkah semasa anda jalankan di server (tampal output & saya bantu debug)
- Menambah systemd/pm2 service file untuk jalankan backend

Selesai.
