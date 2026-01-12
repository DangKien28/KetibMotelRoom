const Sequelize = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    process.env.DB_PASSWORD,
    {
        host: process.env.DB_HOST,
        dialect: 'mysql',
        logging: false, // Tắt log SQL để terminal gọn gàng
        timezone: '+07:00' // Giờ Việt Nam
    }
);

const testConnection = async () => {
    try {
        await sequelize.authenticate();
        console.log('✅ Kết nối cơ sở dữ liệu thành công!');
    } catch (error) {
        console.error('❌ Không thể kết nối đến cơ sở dữ liệu:', error);
    }
};

testConnection();

module.exports = sequelize;