function isUndef(param) {
    return param === null || param === undefined;
}

function isDef(param) {
    return param !== null && param !== undefined;
}


/**
 * 
 * @param {string} hyphen 
 * @param {string} symbol 
 * @returns {Array<string|number>}
 */
function splitHyphen(hyphen, symbol = ',') {
    if (!hyphen) {
        return [];
    }
    return hyphen.split(symbol);
}

/**
 * @param {string} ids 
 * @param {string} symbol 
 * @returns {Array<number>}
 */
function ids2List(ids) {
    return splitHyphen(ids).filter(Boolean).map(Number)
}

/**
 * @description 获取有效的键值对,
 * @param {object} params
 * @returns {object}
 */
function getValidProp(params) {
    let maps;
    Object.keys(params).forEach((key) => {
        if (isDef(params[key])) {
            maps = maps || {};
            maps[key] = params[key];
        }
    });
    return maps;
}

/**
 * @description 获取两个数组的差异
 * @param {Array<any>} origin 
 * @param {Array<any>} fresh 
 */
function getIdsDiff(origin, fresh) {
    const summer = origin.concat(fresh);
    const originSet = new Set(origin);
    const freshSet = new Set(fresh);
    const adds = [];
    const dels = [];
    summer.forEach(ele => {
        if (originSet.has(ele) && !freshSet.has(ele)) {
            dels.push(ele);
        }
        if (!originSet.has(ele) && freshSet.has(ele)) {
            adds.push(ele);
        }
    });
    return [adds, dels];
}

exports.isUndef = isUndef;
exports.isDef = isDef;
exports.getValidProp = getValidProp; 
exports.ids2List = ids2List; 







