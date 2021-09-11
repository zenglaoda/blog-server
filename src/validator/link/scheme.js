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
    url: {
        type: 'url',
        required: true,
        max: 100
    },
    description: {
        type: 'string',
        max: 300,
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
    },
    tagIds: {
        type: 'string',
    }
};