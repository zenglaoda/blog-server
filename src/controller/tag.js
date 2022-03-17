const Controller = require('../lib/controller');
const tagService = require('../service/tag');

class TagController extends Controller{
    constructor() {
        super();
        this.service = tagService;
    }

    getList(ctx) {
        return this.service.getList(ctx.request.query)
            .then((res) => {
                ctx.body = this.message.success(res); 
            })
            .catch((err) => {
                ctx.body = this.message.fail(err, '获取标签列表失败!');
            });
    }

    getItem(ctx) {
        return this.service.getItem(ctx.request.query)
            .then((res) => {
                ctx.body = this.message.success(res); 
            })
            .catch((err) => {
                ctx.body = this.message.fail(err, '获取标签信息失败!');
            });
    }

    create(ctx) {
        return this.service.create(ctx.request.body)
            .then((res) => {
                ctx.body = this.message.success(res, '创建标签成功!');
            })
            .catch((err) => {
                ctx.body = this.message.fail(err, '创建标签失败!');
            });
    }

    update(ctx) {
        return this.service.update(ctx.request.body)
            .then((res) => {
                ctx.body = this.message.success(res, '修改成功!'); 
            })
            .catch((err) => {
                ctx.body = this.message.fail(err, '更新标签失败!');
            });
    }
    
    destroy(ctx) {
        return this.service.destroy(ctx.request.body)
            .then((res) => {
                ctx.body = this.message.success(res); 
            })
            .catch((err) => {
                ctx.body = this.message.fail(err, '删除标签失败!');
            });
    }

    getAssociations(ctx) {
        return this.service.getAssociations()
            .then((res) => {
                ctx.body = this.message.success(res); 
            })
            .catch((err) => {
                ctx.body = this.message.fail(err, '请求错误!');
            });

    }
}
module.exports = new TagController();