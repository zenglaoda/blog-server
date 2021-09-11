exports.getMapIds = function getMapIds(maps, keys = []) {
    if (!keys.length) {
        keys = Object.keys(maps);
    }
    return keys.map(key => maps[key].value);
}

// 文章状态
exports.ARTICLE_STATUS = {
    all: { label: '全部状态', value: '' },
    finished: { label: '完成', value: '1' },
    draft: { label: '草稿', value: '2' },
};


// 笔记与目录的关联类型
exports.NOTE_TYPE = {
    link: { label: '链接', value: '1' },
    article: { label: '文章', value: '2' }
};