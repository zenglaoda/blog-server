const status = {
    200: 'success',
    500: 'server error',
    400: 'param error',
    401: 'access denied',
    404: 'not found'
};

class Message {
    constructor() {

    }

    /**
     * @description  正常返回数据
     * @param {any} data 
     * @param {string} message 
     * @returns {object}
     */
    success(data, message) {
        return {
            code: 200,
            message,
            data,
        }
    }

    /**
     * @description 处理错误信息
     * @param {Error} error 
     * @param {string} error.message 
     * @param {number} error.code 
     * @param {string} message
     * @returns {object}
     */ 
    fail(error, message) {
        if (error.code) {
            error.message = error.message || message;
            return error;
        }

        if (process.env.NODE_ENV === 'development') {
            return {
                code: 500,
                message: error.message || message,
            };
        }
        return {
            code: 500,
            message: message,
        };
    }    

    /**
     * @description 参数错误提示信息
     * @param {string} message 
     * @returns {Error}
     */
    param(message) {
        throw ({
            code: 400,
            message: message || status[400],
        });
    }

    /**
     * @description 服务端错误提示信息，如操作失败
     * @param {string} message 
     * @returns {Error}
     */
    server(message) {
        throw ({
            code: 500,
            message: message || status[500]
        });
    }

}

module.exports = new Message();
