const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Serve Static Frontend Files
app.use(express.static(path.join(__dirname, '../portfolio')));

// Mock database (could be replaced with MongoDB/PostgreSQL)
let submissions = [];

// Routes
app.get('/', (req, res) => {
    res.send('Portfolio Backend API is running...');
});

// Contact Form Endpoint
app.post('/api/contact', (req, res) => {
    const { name, email, message } = req.body;

    if (!name || !email || !message) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    const newSubmission = {
        id: Date.now(),
        name,
        email,
        message,
        date: new Date()
    };

    submissions.push(newSubmission);
    
    console.log('New Contact Submission:', newSubmission);

    // In a real app, you would send an email here using Nodemailer
    res.status(201).json({ 
        message: 'Message received successfully!',
        submission: newSubmission 
    });
});

// API endpoint to view submissions (for demo purposes)
app.get('/api/submissions', (req, res) => {
    res.json(submissions);
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
