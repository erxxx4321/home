import express from 'express';
import db from '../db/conn.mjs';

const router = express.Router();

router.post('/', async (req, res) => {
	let products = await db.collection('Product');
	let result = await products.find({ category: req.body.category }).toArray();
	res.send(result).status(200);
});

export default router;
