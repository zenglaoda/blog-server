const Router = require('koa-router');
const link = require('../controller/link');
const tag = require('../controller/tag');
const article = require('../controller/article');

const router = new Router({
    prefix: '/api'
});

router.get('/link/getList', ctx => link.getList(ctx));
router.get('/link/getItem', ctx => link.getItem(ctx));
router.post('/link/create', ctx => link.create(ctx));
router.post('/link/update', ctx => link.update(ctx));
router.post('/link/destroy', ctx => link.destroy(ctx));

router.get('/article/getList', ctx => article.getList(ctx));
router.get('/article/getDraftList', ctx => article.getDraftList(ctx));
router.get('/article/getItem', ctx => article.getItem(ctx));
router.post('/article/create', ctx => article.create(ctx));
router.post('/article/update', ctx => article.update(ctx));
router.post('/article/updateStatus', ctx => article.updateStatus(ctx));
router.post('/article/destroy', ctx => article.destroy(ctx));

router.get('/tag/getList', ctx => tag.getList(ctx));
router.get('/tag/getItem', ctx => tag.getItem(ctx));
router.post('/tag/create', ctx => tag.create(ctx));
router.post('/tag/update', ctx => tag.update(ctx));
router.post('/tag/destroy', ctx => tag.destroy(ctx));

module.exports = router;