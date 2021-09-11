const Sequelize = require('sequelize');
const sequelize = require('../lib/sequelize');
const { scheme, common } = require('./scheme');

const link = sequelize.define('link', 
    {
        id: scheme.id, 
        title: scheme.title, 
        tagId: scheme.tagId, 
        keyword: scheme.keyword,
        description: scheme.description, 
        url: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true,
            comment: '链接地址',
            validate: {
                isUrl: true,
                len: [4, 100]
            }
        },
        ...common
    },
    {
        comment: '链接表',
    }
);

module.exports = link;