const {DataTypes} = require('sequelize')
const sequelize = require('../config/database')
const { underscoredIf } = require('sequelize/lib/utils')

const User = sequelize.define('User', 
    {
        id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        full_name: {
            type: DataTypes.STRING(100),
            allowNull: false
        },
        email: {
            type: DataTypes.STRING(100),
            allowNull: false,
            unique: true,
            validate: {isEmail: true}
        },
        phone_number: {
            type: DataTypes.STRING(20),
            allowNull: false
        },
        password_hash: {
            type: DataTypes.STRING(255),
            allowNull: false
        },
        role: {
            type: DataTypes.ENUM('renter', 'landlord', 'admin'),
            defaultValue: 'renter'
        },
        avatar_url: {
            type: DataTypes.STRING(255),
            allowNull: true
        },
        tax_code: {
            type: DataTypes.STRING(20),
            allowNull: true
        }
    },
    {
        tableName: 'users',
        timestampts: true,
        underscored: true,
        charset: 'utf8mb4',
        collate: 'utf8mb4_unicode_ci'
    }
)

module.exports = User