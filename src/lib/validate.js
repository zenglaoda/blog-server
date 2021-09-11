const Schema = require('async-validator').default;
const message = require('./message');


// TODO: 未定义的字段的校验
module.exports = function validate(target, key, schema, options) {
    const origin = target.prototype[key];

    target.prototype[key] = async function(data) {
        // async-validate库依赖对象的hasOwnerProperty方法，但是请求体对象是由Object.create(null)创建的
        data = Object.assign({}, data);
        const validator = new Schema(schema);
        await validator.validate(data, { first: true })
            .catch((error) => {
                console.log(error);
                message.param(error.errors[0].message)
            });
        return origin.call(this, data);
    }    
}
