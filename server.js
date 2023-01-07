import { handler } from './build/handler.js';
import cors from 'cors';
import helmet from 'helmet';
import express from 'express';

const app = express();
app.use(cors());
app.use(helmet());

// add a route that lives separately from the SvelteKit app
app.get('/test', (req, res) => {
	res.end('ok');
});

// let SvelteKit handle everything else, including serving prerendered pages and static assets
app.use(handler);

app.listen(3000, () => {
	console.log('listening on port 3000');
});
