const Controller = require('../lib/controller');
const articleService = require('../service/article');

class ArticleController extends Controller{
    constructor() {
        super();
        this.service = articleService;
    }

    getList(ctx) {
        return this.service.getList(ctx.request.query)
            .then((data) => {
               return this.message.success(data);
            })
            .catch((err) => {
                return this.message.fail(err, '获取列表失败!');
            })
            .then((body) => {
                ctx.body = body;
            });
    }

    getItem(ctx) {
        return this.service.getItem(ctx.request.query)
            .then((data) => {
                return this.message.success(data);
            })
            .catch((err) => {
                return this.message.fail(err, '获取详情失败!');
            })
            .then((body) => {
                ctx.body = body;
            });
    }

    create(ctx) {
        return this.service.create(ctx.request.body)
            .then((data) => {
               return this.message.success(data, '保存成功!');
            })
            .catch((err) => {
                return this.message.fail(err, '保存失败!');
            })
            .then((body) => {
                ctx.body = body;
            });
    }

    update(ctx) {
        return this.service.update(ctx.request.body)
            .then((data) => {
                return this.message.success(data, '更新成功!');
            })
            .catch((err) => {
                return this.message.fail(err, '更新失败!');
            })
            .then((body) => {
                ctx.body = body;
            });
    }

    updateStatus(ctx) {
        return this.service.updateStatus(ctx.request.body)
            .then((data) => {
                return this.message.success(data, '更新成功!');
            })
            .catch((err) => {
                return this.message.fail(err, '更新失败!');
            })
            .then((body) => {
                ctx.body = body;
            });
    }

    destroy(ctx) {
        return this.service.destroy(ctx.request.body)
            .then((data) => {
                return this.message.success(data, '删除成功!');
            })
            .catch((err) => {
                return this.message.fail(err, '删除失败!');
            })
            .then((body) => {
                ctx.body = body;
            });
    }
}
module.exports = new ArticleController();