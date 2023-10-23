import express from 'express';
import cors from 'cors';
import './loadEnvironment.mjs';
import users from './routes/users.mjs';
import auth from './routes/auth.mjs';
import categories from './routes/categories.mjs';
import products from './routes/products.mjs';

const PORT = process.env.PORT || 5050;
const app = express();

app.use(cors());
app.use(express.json());

// Load the routes
app.use('/users', users);
app.use('/auth', auth);
app.use('/categories', categories);
app.use('/products', products);

// Global error handling
app.use((err, _req, res, next) => {
	res.status(500).send('Uh oh! An unexpected error occured.');
});

// start the Express server
app.listen(PORT, () => {
	console.log(`Server is running on port: ${PORT}`);
});
