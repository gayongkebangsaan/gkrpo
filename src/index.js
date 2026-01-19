/**
 * AppGK Backend (Node + Prisma)
 * - GET /                      : health check
 * - GET /api/jadual-yuran-bengkung : senarai JadualYuranBengkung (amount dipaparkan 2 perpuluhan)
 */

require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const app = express();

app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 4000;

function to2dp(val) {
  if (val === null || val === undefined) return '0.00';
  const num = Number(val);
  if (Number.isNaN(num)) return '0.00';
  return num.toFixed(2);
}

app.get('/', (req, res) => {
  res.json({ status: 'OK', message: 'Gayong Kebangsaan Backend (scaffold)' });
});

app.get('/api/jadual-yuran-bengkung', async (req, res) => {
  try {
    const rows = await prisma.jadualYuranBengkung.findMany({
      orderBy: { id: 'asc' },
    });

    const out = rows.map((r) => ({
      ...r,
      gurulatihAmount: to2dp(r.gurulatihAmount),
      negeriAmount: to2dp(r.negeriAmount),
      pssgmkHqAmount: to2dp(r.pssgmkHqAmount),
      totalAmount: to2dp(r.totalAmount),
    }));

    res.json(out);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Gagal ambil data' });
  }
});

app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});
