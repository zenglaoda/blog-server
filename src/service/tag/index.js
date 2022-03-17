const Service = require('../../lib/service');
const validate = require('../../lib/validate');
const linkModel = require('../../model/link');
const articleModel = require('../../model/article');
const sequelize = require('sequelize');
const Op = sequelize.Op;

class TagService extends Service {
    constructor() {
        super();
        this.model = this.models.tag;
    }
    
    getList() {
        return this.model.findAll();
    }

    /**
     * @description 获取单个标签信息
     * @param {object} query
     * @param {number} query.id
     * @returns {object} 单个标签实体 
     */
    getItem(query = {}) {
        const where = {
            id: query.id
        };
        return this.model.findOne({ where })
            .then((item) => {
                if (item) {
                    return item;
                }
                this.message.param(`不存在的标签id:${where.id}`);
            });
    }

    /**
     * @description 创建标签
     * @param {object} body 
     * @param {number} body.pid 父标签名
     * @param {string} body.name 标签名
     * @returns {object} 创建记录
     */
    async create(body = {}) {
        const item = await this.model.findOne({
            where: {
                pid: body.pid,
                name: body.name
            }
        });
        item && this.message.param(`该层级已存在名称为${body.name}的标签`);

        // TODO: 校验pid是否为一级目录id，防止创建三级目录
        return this.model.create({
            pid: body.pid,
            name: body.name,
            description: body.description
        }).then((record) => record);
    }

    /**
     * @description 更改单个标签信息
     * @param {object} body 
     * @param {number} body.id 标签id
     * @param {number} body.pid 父标签id
     * @param {string} body.name 标签名
     * @param {string} body.description
     */
    async update(body) {
        if (body.name) {
            const similarItem = await this.model.findOne({
                where: {
                    id: {
                        [Op.ne]: body.id
                    },
                    pid:  body.pid,
                    name: body.name,       
                }
            });
            similarItem && this.message.param(`该层级已存在名称为${body.name}的标签`);
        }

        return this.model.update(
            {
                pid: body.pid,
                name: body.name,
                description: body.description
            }, 
            { 
                where: { id: body.id }
            }
        ).then(() => true);
    }

    /**
     * @description 删除某个标签
     * @param {object} body
     * @description {boolean} 是否删除成功 
     */
    async destroy(body = {}) {
        const tagId = body.id;
        const getChildCount = () => this.model.count({ where: { pid: tagId } });
        const getLinkCount = () => linkModel.count({ where: { tagId } });
        const getArticleCount = () => articleModel.count({ where: { tagId } });
        const conditions = [getChildCount, getLinkCount, getArticleCount];

        for (let i = 0; i < conditions.length; i++) {
            const count = await conditions[i]()
            if (count) {
                this.message.param('该标签正在使用中!');
                return;
            }
        }

        return this.model.destroy({
            where: {
                id: body.id
            }
        })
            .then(() => true)
    }

    /**
     * @description 从tagIds列表里面找出二级tagId对应的实体
     * @param {object} tagIds: 标签id
     * @returns {array} 有效的标签 
     */
     getLevel2Tags({ tagIds = [] }) {
        return this.model.findAll({
            where: {
                id: {
                    [Op.in]: tagIds
                },
                pid: {
                    [Op.ne]: 0
                }
            }
        })
        .then((list) => {
            if (!list || !list.length) {
                this.message.param('error in tagService.getLevel2Tags')
            }
            return list || [];
        });
    }

    /**
     * @description 根据tagIds获取二级标签id的并集
     * @param {object} body
     * @param {number[]} body.tagIds: 标签id
     * @returns {number[]} 
     */
    async getUnionTags({ tagIds }) {
        let tags = await this.model.findAll({
            where: {
                id: {
                    [Op.in]: tagIds
                }
            }
        });
        if (!tags || !tags.length) {
            return [];
        }
        const parentIds = [];
        const childIds = [];
        let childTags = [];
        tags.forEach(ele => {
            ele.pid ? childIds.push(ele.id) : parentIds.push(ele.id);
        });
        if (parentIds.length) {
            childTags = await this.model.findAll({
                where: {
                    pid: {
                        [Op.in]: parentIds
                    }
                }
            });
            childTags = childTags || [];
        }
        const tagIdSet = new Set(childTags.map(ele => ele.id).concat(childIds));
        return [...tagIdSet];  
    }

    /**
     * @description 获取标签关联的文章数与链接数
     */
    async getAssociations() {
        const options = { type: sequelize.QueryTypes.SELECT };
        const linkSQL =    `SELECT tagId, COUNT(tagId) AS count FROM link GROUP BY tagId`;
        const articleSQL = `SELECT tagId, COUNT(tagId) AS count FROM article GROUP BY tagId`;
        const linkRes = await this.query(linkSQL, options);
        const articleRes = await this.query(articleSQL, options);
        const toMap = (list) => {
            if (!Array.isArray(list)) return {};
            return list.reduce((map, next) => {
                map[next.tagId] = next.count;
                return map;
            }, {});
        }
        return {
            link: toMap(linkRes),
            article: toMap(articleRes),
        };
    }
}

validate(TagService, 'create', require('../../validator/tag/create'));
validate(TagService, 'destroy ', require('../../validator/common/id'));
validate(TagService, 'update', require('../../validator/tag/update'));
validate(TagService, 'getItem', require('../../validator/common/id'));
validate(TagService, 'getLevel2Tags ', require('../../validator/tag/getLevel2Tags'));
validate(TagService, 'getUnionTags ', require('../../validator/tag/getUnionTags'));

module.exports = new TagService();