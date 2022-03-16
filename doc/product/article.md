# 文章表设计结构

### 建表语句
```sql
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `title` varchar(60) NOT NULL COMMENT '文章标题',
  `tagId` int NOT NULL COMMENT '标签id',
  `description` varchar(300) DEFAULT NULL COMMENT '文章描述',
  `content` text NOT NULL COMMENT '文章内容',
  `status` char(1) NOT NULL DEFAULT '2' COMMENT '文章状态1.完成 2.草稿 ',
  `keyword` varchar(300) NOT NULL COMMENT '文章关键字，便于搜索引擎收录',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3
```

### 功能设计
1. 一个文章只能属于一个二级标签，tagId 对应二级标签的id
2. 文章内容的格式暂时只支持 md 格式
3. 文章的状态可以从 完成 -> 草稿， 草稿 -> 完成