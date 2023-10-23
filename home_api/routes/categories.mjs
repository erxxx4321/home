import express from 'express';
import db from '../db/conn.mjs';
import { ObjectId } from 'mongodb';
import bcrypt from 'bcrypt';

const router = express.Router();

router.get('/', async (req, res) => {
	let cates = await db.collection('Category');
	let results = await cates.find({}).toArray();
	res.send(results).status(200);
});

export default router;
