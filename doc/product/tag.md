# 文章标签表结构设计

### 建表语句
```sql
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `pid` int NOT NULL COMMENT '父级标签id',
  `name` varchar(30) NOT NULL COMMENT '标签名',
  `description` varchar(300) NOT NULL COMMENT '标签描述',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COMMENT='标签' 
```

### 功能设计
1. 标签层级最多两级，一级标签下面不能关联文章，只有二级标签才能关联文章
2. 关联了文章的标签不能删除
3. 二级标签可以修改所属的一级标签