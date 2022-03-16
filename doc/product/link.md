# 链接表管理

### 建表语句
```sql
CREATE TABLE `link` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '链接id',
  `title` varchar(60) NOT NULL COMMENT '分享的标题',
  `tagId` int NOT NULL COMMENT '标签Id',
  `description` varchar(300) NOT NULL COMMENT '内容描述',
  `url` varchar(100) NOT NULL COMMENT '链接地址',
  `keyword` varchar(300) NOT NULL COMMENT '关键词',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='链接表'
```

### 功能设计
1. 一个链接只能属于一个二级标签
