module.exports = {
    id: {
        type: 'integer',
        required: true,
    },
    pid: {
        type: 'integer',
        required: true
    },
    name: {
        type: 'string',
        required: true,
        min: 1,
        max: 30
    },
    description: {
        type: 'string',
        max: 300
    }
};