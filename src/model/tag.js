const Sequelize = require('sequelize');
const sequelize = require('../lib/sequelize');
const { scheme, common } = require('./scheme');

const tag = sequelize.define('tag', 
    {
        id: scheme.id,
        description: scheme.description,
        pid: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        name: {
            type: Sequelize.STRING,
            allowNull: false,
            validate: {
                len: [2, 30]
            }
        },
        ...common
    },
    {
        comment: '标签表'
    }
);

module.exports = tag;