const commonScheme = require('../common/scheme');

const  { getMapIds, ARTICLE_STATUS } = require('../../enum/note');

module.exports = {
    status: {
        type: 'enum',
        required: false,
        enum: getMapIds(ARTICLE_STATUS) 
    },
    endDate: commonScheme.endDate,
    startDate: commonScheme.startDate,
    page: commonScheme.page,
    pageSize: commonScheme.pageSize,
    keyword: commonScheme.keyword,
};