const moment = require('moment');

/**
 * @param  {...number} args 
 * @returns 
 */
exports.timestampFormat = function timestampFormat(...args) {
    const format = time => moment(parseInt(time)).format('YYYY-MM-DD HH:mm:SS');
    if (args.length === 1) {
        return format(args[0]);
    }
    const data = args.map(format); 
    return data;
}
