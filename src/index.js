// Server Express ringkas untuk semak JadualYuranBengkung
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 4000;

app.get('/', (req, res) => {
  res.json({ status: 'OK', message: 'Gayong Kebangsaan Backend (scaffold)' });
});

app.get('/api/jadual-yuran-bengkung', async (req, res) => {
  try {
    const rows = await prisma.jadualYuranBengkung.findMany({
      orderBy: { id: 'asc' }
    });
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Gagal ambil data' });
  }
});

app.listen(PORT, () => {
  console.log(`Server berjalan di http://localhost:${PORT}`);
});

