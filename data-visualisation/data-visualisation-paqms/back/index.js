import express from 'express'
import cors from 'cors'

const app = express()
const port = 5000

const corsOptions = {
    origin: true,
    credentials: true,
}

app.use(cors(corsOptions))
app.use(express.json())
app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.listen(port,() => {
    console.log(`Server listening on port ${port}`)
    console.log(`http://localhost:${port}`)
})

export default app