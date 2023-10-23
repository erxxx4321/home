import express from 'express';
import db from '../db/conn.mjs';
import bcrypt from 'bcrypt';

const router = express.Router();

router.post('/', async (req, res) => {
	try {
		let users = await db.collection('User');
		let user = await users.findOne({ account: req.body.account });
		if (!user) {
			return res.status(400).send('Incorrect account!');
		}

		const validPassword = await bcrypt.compare(req.body.password, user.password);
		if (!validPassword) {
			return res.status(400).send('Incorrect password!');
		}
		user.password = '';
		res.status(200).send(user);
	} catch (error) {
		console.error(error);
		return res.send('Connection error!');
	}
});

export default router;
