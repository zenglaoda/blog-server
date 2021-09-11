const moment = require('moment');
const Sequelize = require('sequelize');

/**
 *  常用字段属性定义
*/
exports.scheme = {
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        comment: '唯一id'
    },
    title: {
        type: Sequelize.STRING,
        allowNull: false,
        comment: '标题',
        defaultValue: '',
        validate: {
            len: [2, 60]
        }
    },
    description: {
        type: Sequelize.STRING,
        comment: '描述',
        defaultValue: '',
        validate: {
            len: [0, 200]
        }
    },
    tagId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        comment: '所属标签',
    },
    keyword: {
        type: Sequelize.STRING,
        comment: '关键字，利于搜索引擎收录',
        defaultValue: '',
        validate: {
            len: [1, 200]
        }
    },
};

/**
 * @description 每个表都含有的字段属性定义
*/
exports.common = {
    createdAt: {
        type: Sequelize.DATE,
        get() {
            return moment(this.getDataValue('createdAt')).format('x') - 0;
        }
    },
    updatedAt: {
        type: Sequelize.DATE,
        get() {
            return moment(this.getDataValue('createdAt')).format('x') - 0;
        }
    }
};