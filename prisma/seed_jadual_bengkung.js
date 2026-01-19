/**
 * Skrip seed untuk import CSV -> JadualYuranBengkung (Decimal)
 * Jalankan: npm run seed
 *
 * Pastikan:
 *  - anda telah jalankan `npm run prisma:generate`
 *  - sambungan DB (DATABASE_URL) betul di .env
 *  - anda telah jalankan migrations (lihat README)
 */
const fs = require('fs');
const path = require('path');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

function toDecimalString(n) {
  // ensure two decimal places and return string (Prisma accepts string for Decimal)
  return Number(n).toFixed(2);
}

async function main() {
  const csvPath = path.join(__dirname, '..', 'jadual pembahagian yuran bengkung.csv');
  if (!fs.existsSync(csvPath)) {
    console.error('CSV tidak ditemui:', csvPath);
    process.exit(1);
  }
  const content = fs.readFileSync(csvPath, 'utf8');
  const lines = content
    .split(/\r?\n/)
    .map(l => l.trim())
    .filter(l => l.length > 0);

  // Buang header jika ada
  const first = lines[0].split(',');
  if (first[0] === '' || /gurulatih/i.test(first[1] || '')) {
    lines.shift();
  }

  for (const line of lines) {
    const parts = line.split(',').map(p => p.trim());
    const nama = parts[0];
    if (!nama) continue;

    // tolerant parsing: accept integers or decimals in CSV
    const gur = parseFloat(parts[1] || '0') || 0;
    const negeri = parseFloat(parts[2] || '0') || 0;
    const hq = parseFloat(parts[3] || '0') || 0;
    const total = gur + negeri + hq;

    await prisma.jadualYuranBengkung.upsert({
      where: { namaBengkung: nama },
      update: {
        gurulatihAmount: toDecimalString(gur),
        negeriAmount: toDecimalString(negeri),
        pssgmkHqAmount: toDecimalString(hq),
        totalAmount: toDecimalString(total)
      },
      create: {
        namaBengkung: nama,
        gurulatihAmount: toDecimalString(gur),
        negeriAmount: toDecimalString(negeri),
        pssgmkHqAmount: toDecimalString(hq),
        totalAmount: toDecimalString(total)
      }
    });

    console.log(
      `Seeded: ${nama} => total RM${toDecimalString(total)} (G:${toDecimalString(gur)} N:${toDecimalString(negeri)} HQ:${toDecimalString(hq)})`
    );
  }

  console.log('Seed selesai.');
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

