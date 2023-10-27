import express from 'express';
import db from '../db/conn.mjs';
import { ObjectId } from 'mongodb';
import bcrypt from 'bcrypt';

const router = express.Router();

router.get('/', async (req, res) => {
	let users = await db.collection('User');
	let results = await users.find({}).toArray();
	res.send(results).status(200);
});

router.post('/', async (req, res) => {
	try {
		let users = await db.collection('User');
		let user = await users.findOne({ account: req.body.account });
		if (user) {
			return res.status(400).send('That user already exists!');
		} else {
			const salt = await bcrypt.genSalt(10);
			req.body.password = await bcrypt.hash(req.body.password, salt);
			let result = await users.insertOne(req.body);
			let insertedId = result.insertedId;
			let cart_body = {
				user_id: insertedId,
				total: 0,
				createdAt: new Date(Date.now()).toLocaleString(),
			};
			let cart = await db.collection('Cart');
			let cart_result = await cart.insertOne(cart_body);
			res
				.send({
					register: result,
					opencart: cart_result,
				})
				.status(200);
		}
	} catch (error) {
		console.error(error);
		return res.send('Connection error!');
	}
});

router.patch('/:id', async (req, res) => {
	const query = { _id: new ObjectId(req.params.id) };
	const updates = {
		$set: req.body,
	};

	let users = await db.collection('User');
	let result = await users.updateOne(query, updates);

	res.send(result).status(200);
});

router.delete('/:id', async (req, res) => {
	const query = { _id: new ObjectId(req.params.id) };

	let users = await db.collection('User');
	let result = await users.deleteOne(query);

	res.send(result).status(200);
});

export default router;
