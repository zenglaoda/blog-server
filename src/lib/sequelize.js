const Sequelize = require('sequelize');
const { database } = require('../../config');

const sequelize = new Sequelize(
  database.database,
  database.username,
  database.password,
  {
    host: database.host,
    port: database.port,
    dialect: 'mysql',
    define: {
      // `timestamps` 字段指定是否将创建 `createdAt` 和 `updatedAt` 字段.
      // 该值默认为 true,
      timestamps: true,

      // 冻结表名，防止插件添加复数
      freezeTableName: true,
    }
  }
);

sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });

module.exports = sequelize;