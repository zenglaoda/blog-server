const {Op} = require('sequelize');
const Service = require('../../lib/service');
const validate = require('../../lib/validate');
const { getValidProp, ids2List } = require('../../lib/utils');
const { timestampFormat } = require('../../common/utils');
const tagService = require('../tag');
const { ARTICLE_STATUS } = require('../../enum/note');

class ArticleService extends Service {
    constructor() {
        super();
        this.model = this.models.article;
    }

    /**
     * @description 分页获取文章列表
     * @param {object} query
     * @returns {array[object]} 创建时间 
     */
    async getList(query = {}) {
        // TODO: 优化查询条件
        let { keyword = '', tagIds, status, startDate, endDate, page, pageSize } = query;
        page = Number(page);
        pageSize = Number(pageSize);
        tagIds = ids2List(tagIds);
        keyword = (keyword || '').trim();

        const where = {};

        // keyword
        if (keyword.length) {
            where.title = {
                [Op.like]: `%${keyword}%`
            };
        }

        // tagIds
        if (tagIds.length) {
            tagIds = await tagService.getUnionTags({tagIds});
            where.tagId = {
                [Op.in]: tagIds
            };
        }

        // 状态
        if (status) {
            where.status = {
                [Op.in]: [status]
            };
        } else {
            where.status = {
                [Op.in]: [ARTICLE_STATUS.draft.value, ARTICLE_STATUS.finished.value]
            };
        }

        // 时间
        if (startDate && endDate) {
            where.updatedAt = {
                [Op.between]: timestampFormat(startDate, endDate)
            };
        }

        return this.model.findAndCountAll({
            offset: (page - 1) * pageSize,
            limit: pageSize,
            attributes: ['id', 'title', 'description', 'tagId', 'createdAt', 'updatedAt'],
            order: [
                ['updatedAt', 'DESC']
            ],
            where
        })
            .then((res) => {
                return {
                    rows: res.rows,
                    count: res.count
                };
            })
    }

    /**
     * @description 获取文章详情
     * @param {object} query 
     * @param {number} query.id 
     * @returns 
     */
    async getItem(query = {}) {
        let item = await this.model.findOne({
            where: {
                id: query.id
            },
        });
        if (!item) {
            this.message.param('无效的文章id');
        }
        item = item.toJSON();
        item.tag = await tagService.getItem({ id: item.tagId });
        return item;
    }

    /**
     * @description 创建文章
     * @param {object} body 
     * @param {string} body.title 
     * @param {string} body.description 
     * @param {string} body.content 
     * @param {string} body.keyword 
     * @param {number} body.tagId
     * @param {string} body.status
     * @returns {Promise<object>}
     */
    async create(body = {}) {
        return this.model.create(body)
            .then((record) => {
                return record;
            });
    }

    /**
     * @description 更新文章
     * @param {object} body 
     * @param {string} body.title 
     * @param {string} body.description 
     * @param {string} body.content 
     * @param {string} body.keyword 
     * @param {string} body.status 1.已完成, 2:草稿 
     * @param {number} body.tagId
     * @param {number} body.id
     * @returns {Promise<true | Error>}
     */
    async update(body = {}) {
        const where = {
            id: body.id
        };

        const data = getValidProp({
            title: body.title,
            description: body.description,
            content: body.content,
            keyword: body.keyword,
            tagId: body.tagId,
            status: body.status,
        });

        if (!data) {
            this.message.param('参数错误!');
        }

        return this.model.update(data, { where })
            .then(() => {
                return  this.getItem(where);
            });
        
    }

    /**
     * @description 删除文章 
     * @param {object} query 
     * @param {number} query.id 
     * @returns {Promise<true | Error>}
     */
    async destroy(query = {}) {
        return this.model.destroy({
            where: {
                id: query.id
            }
        })
            .then(() => true);
    }
}


validate(ArticleService, 'getItem', require('../../validator/common/id'));

validate(ArticleService, 'getList', require('../../validator/article/getList'));

validate(ArticleService, 'create', require('../../validator/article/create'));

validate(ArticleService, 'update', require('../../validator/article/update'));

validate(ArticleService, 'destroy', require('../../validator/common/id'));

module.exports = new ArticleService();