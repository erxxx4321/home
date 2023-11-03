import express from 'express';
import db from '../db/conn.mjs';
import { ObjectId } from 'mongodb';

const router = express.Router();

router.post('/getItems', async (req, res) => {
	let cart_data = db.collection('CartItem');
	let cart_arr = await cart_data
		.find({
			user_id: req.body.user_id,
		})
		.toArray();
	let cart_items = [];
	if (cart_arr) {
		for (const c of cart_arr) {
			let products = db.collection('Product');
			let product = await products.findOne({ _id: new ObjectId(c.product_id) });
			let item = {
				cid: c.cart_id,
				name: product.name,
				img: product.img,
				price: product.price,
				qty: c.quantity,
				selected: false,
			};
			cart_items.push(item);
		}

		res.send(cart_items).status(200);
	} else {
		res.send(cart_items).status(200);
	}
});

router.post('/addItem', async (req, res) => {
	try {
		let cart_items = db.collection('CartItem');
		let cart_item = await cart_items.findOne({
			user_id: req.body.user_id,
			product_id: req.body.product_id,
		});

		if (req.body.user_id == '') {
			res.status(400).send('請先登入!');
		} else if (cart_item) res.status(400).send('產品已存在!');
		else {
			let result = await cart_items.insertOne({
				cart_id: '6536075bdf824e326452b011',
				product_id: req.body.product_id,
				quantity: 1,
				createdAt: new Date(Date.now()).toLocaleString(),
				user_id: req.body.user_id,
			});
			res.status(200).send(result);
		}
	} catch (error) {
		console.log(error);
		return res.status(400).send('Connection error!');
	}
});

export default router;
