const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')
const sequelize = require('./config/database')
require('dotenv').config()

const authRoutes = require('./routes/authRoutes')

const app = express()

// --- BẮT LỖI TOÀN CỤC (Thêm đoạn này) ---
// Giúp server không bị tắt đột ngột mà không báo gì
process.on('uncaughtException', (err) => {
    console.error('LỖI CHẾT NGƯỜI (Uncaught Exception):', err);
    // Có thể giữ process sống hoặc exit tùy logic, ở đây log ra để biết
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('LỖI PROMISE KHÔNG ĐƯỢC BẮT (Unhandled Rejection):', reason);
});
// ----------------------------------------

app.use(cors())
app.use(bodyParser.json())

app.use('/api/auth', authRoutes)
app.get('/', (req, res) => res.send('API đang chạy...'))

const PORT = process.env.PORT || 3000;

console.log('--- Đang thử kết nối tới Database... ---'); // Log để biết code đã chạy đến đây

sequelize.sync({ force: false }) // force: false để tránh xóa dữ liệu cũ
.then(() => {
    console.log('✅ Đã kết nối thành công với MySQL Database');
    app.listen(PORT, () => {
        console.log(`🚀 Server đang chạy tại http://localhost:${PORT}`);
    });
})
.catch(err => {
    console.error('❌ KHÔNG THỂ KẾT NỐI DATABASE:');
    console.error('Lý do:', err.message); // In rõ thông báo lỗi
    console.error('Chi tiết:', err);       // In toàn bộ object lỗi
});