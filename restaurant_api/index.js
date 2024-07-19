const express = require('express')

const mongoose = require('mongoose')


const app = express()

const path = require("path");

const restaurant_routes = require('./routes/restaurant_routes')

const menu_routes = require('./routes/menu_routes')

const user_routes = require('./routes/user_routes')

const order_routes = require('./routes/order_routes')

const { verifyUser } = require('./middleware/auth')



mongoose.connect('mongodb://127.0.0.1:27017/Restaurant')
    .then(() => console.log('Connected to mongoDB server'))
    .catch((err) => console.log(err))

app.use(express.json())
app.use(express.static('public'))

app.use(
    "/uploads",
    express.static(path.join(__dirname, "/uploads"))
);

app.get('/', (req, res) => {
    res.send("Hello world")
})

app.use('/restaurants', verifyUser, restaurant_routes)
app.use('/menus', menu_routes)
app.use('/users', user_routes)
app.use('/orders', order_routes)


// app.post('/images', upload.single('photo'), (req,res) => {
//     res.json(req.file)
// })


app.use((err, req, res, next) => {
    console.error(err)
    if (err.name === 'ValidationError') res.status(400)
    else if (err.name === 'CastError') res.status(400)
    console.log(err.message)
    res.json({ error: err.message })
})

app.use((req, res) => {
    res.status(404).json({ error: "Path Not Found" })
})

const server = app.listen(3000, () => {
    console.log('server is running on port 3000')
})

process.on("unhandledRejection", (err, promise) => {
    console.log(`Error: ${err.message}`.red);
    // Close server & exit process
    server.close(() => process.exit(1));
});