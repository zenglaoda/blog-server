const path = require('path');
const fs = require('fs');
const Koa = require('koa');
const koaStatic = require('koa-static');
const bodyParse = require('koa-bodyparser');
const router = require('./router');
const message = require('./lib/message');

const app = new Koa();
app.keys = ['814595325'];

app
    // 静态文件托管
    .use(koaStatic(__dirname+'/public', {
        index: 'index.html',
    }))

    // 跨域设置
    .use(async (ctx, next) => {
        ctx.set('Access-Control-Allow-Origin', '*');
        ctx.set('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With');
        ctx.set('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');
        if (ctx.method == 'OPTIONS') {
          ctx.status = 200; 
        } else {
          await next();
        }
    })

    // 入口中间件，计算响应时间
    .use(async function(ctx, next) {
        const start = Date.now();
        try {   
            await next();
        } catch (err) {
            ctx.body = message.fail(err, '服务器错误');
        }
        const end = Date.now();
        ctx.set('X-Response-Time',  String(Math.ceil(end - start)));
    })

    // 解析请求体
    .use(bodyParse())

    // 权限路由设置
    .use(router.routes())
    .use(router.allowedMethods())

    // 页面不存在信息提示
    .use(async function notFound(ctx){
        // const indexPage = path.resolve(__dirname, 'public/index.html');
        // ctx.status = 200;
        // ctx.set('Content-Type', 'text/html');
        // ctx.body = fs.readFileSync(indexPage);
        ctx.status = 200;
        ctx.set('Content-Type', 'text/html');
        ctx.body = 'page not fund';
    })

    // 捕捉中间件错误,将错误返回给客户端
    .on('error', function(err){
        err.expose = true;
    })

    // 设置启动端口
    .listen(3000, 'localhost', function callback() {
        console.log('success');
    });