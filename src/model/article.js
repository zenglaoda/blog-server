const Sequelize = require('sequelize');
const sequelize = require('../lib/sequelize');
const { scheme, common } = require('./scheme');

const article = sequelize.define('article', 
    {
        id: scheme.id, 
        title: scheme.title, 
        tagId: scheme.tagId, 
        description: scheme.description,
        keyword: scheme.keyword,
        content: {
            type: Sequelize.TEXT,
            allowNull: true,
            defaultValue: '',
            comment: '文章原始内容'
        },
        status: {
            type: Sequelize.ENUM('1', '2'),
            allowNull: false,
            defaultValue: '2',
            comment: '文章状态: 1-完成, 2-草稿',
            validate: {
                isIn: [['1', '2']]
            }
        },
        ...common
    },
    {
        comment: '文章表'
    }
);
  module.exports = article;