function toNumber(value) {
    if (!value) {
        return '';
    }
    const val = Number(value);
    if (isNaN(val)) {
        return String(value);
    }
    return val;
}

function transformTimes(value) {
    if (!value) {
        return null;
    }

    const val = parseInt(value);
    if (String(val).length !== 13) {
        return value;
    }

    const date = new Date(val);
    if (isNaN(date.getFullYear())) {
        return value;
    }
    return val;
}

module.exports = {
    startDate: {
        type: 'date',
        transform: transformTimes
    },
    endDate: {
        type: 'date',
        transform: transformTimes
    },
    page: [
        { required: true },
        { transform: toNumber, type: 'integer', min: 1, max: 999 }
    ],
    pageSize: [
        { required: true },
        { transform: toNumber, type: 'integer', min: 1, max: 100 }
    ],
    keyword: {
        type: 'string',
        max: 30
    },
};