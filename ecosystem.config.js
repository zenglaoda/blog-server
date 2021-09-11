// Options reference: https://pm2.keymetrics.io/docs/usage/application-declaration/

module.exports = {
  apps : [{
    // 进程名
    name: 'app',
    //执行文件
    script: './src/app.js',
    instances: 1,
    autorestart: true,
    watch: ['./src'],
    ignore_watch: [
      'public',
      'note',
      'node_modules',
    ],
    max_memory_restart: '500M',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }],
};


/*
常用命令:
  创建ecosystem.config文件
    pm2 ecosystem

  根据配置启动
    pm2 start/restart/stop/delete ecosystem.config

  
  启动指定的环境：
    pm2 start ecosystem.config -env development

  执行文件
    pm2 start ./src/app.js

  列出pm2管理的所有应用程序
    pm2 ls

  查看历史日志
    pm2 logs --lines 200

  实时打印日志
    pm2 logs
  
  查看仪表盘
    pm2 monit
  
  显示指定应用详情
    pm2 show id或进程名
  
  停止某个项目
    pm2 stop id或进程名

  停止所有项目
    pm2 stop all
  
  重启某个项目
    pm2 restart id或进程名
  
  重启所有项目
    pm2 restart all

  重载某个项目
    pm2 reload id或进程名

  删除某个项目
    pm2 delete id或进程名

  删除所有项目
    pm2 delete all
  
  杀掉pm2管理的所有进程
    pm2 kill



  
  
*/