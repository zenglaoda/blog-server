const { getMapIds, ARTICLE_STATUS } = require('../../enum/note');

module.exports = {
    id: {
        type: 'integer',
        required: true
    },
    title: {
        type: 'string',
        required: true,
        max: 60,
        min: 2
    },
    description: {
        type: 'string',
        max: 300,
    },
    content: {
        type: 'string',
        required: false
    },
    status: {
        type: 'enum',
        required: true,
        enum: getMapIds(ARTICLE_STATUS, ['finished', 'draft'])
    },
    keyword: {
        type: 'string',
        required: true,
        max: 300,
        min: 1
    },
    tagId: {
        type: 'integer',
        required: true,
    }
};