const { scheme } = require('../../model/scheme');
const commonScheme = require('../common/scheme');

module.exports = {
    endDate: commonScheme.endDate,
    startDate: commonScheme.startDate,
    page: commonScheme.page,
    pageSize: commonScheme.pageSize,
    keyword: commonScheme.keyword,
    tagIds: scheme.tagIds
};