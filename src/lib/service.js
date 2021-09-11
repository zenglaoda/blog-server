const link = require('../model/link');
const article = require('../model/article');
const tag = require('../model/tag');
const message = require('./message');
const sequelize = require('./sequelize');

class Service {
    constructor() {
        this.models = { article, link, tag };
        this.message = message;
    }

    query(...args) {
        return sequelize.query(...args);
    }
}

module.exports = Service;