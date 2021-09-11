const Sequelize = require('sequelize');
const Service = require('../../lib/service');
const validate = require('../../lib/validate');
const { ids2List } = require('../../lib/utils');
const { filterUndef } = require('../../lib/utils');
const tagService = require('../tag');
const { UniqueConstraintError } = Sequelize;

class LinkService extends Service {
    constructor() {
        super();
        this.model = this.models.link;
    }

    /**
     * @description 分页获取链接列表
     * @param {object} query
     * @param {string} query.keyword
     * @param {string} query.tagIds
     * @param {number} query.startDate
     * @param {number} query.endDate
     * @param {number} query.page
     * @param {number} query.pageSize
     * @returns {object[]} 创建时间，链接所属标签， 
     */
    async getList(query = {}) {
        // TODO: 完善查询功能
        let { keyword = '', tagIds, startDate, endDate, page, pageSize } = query;
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

        // 时间
        if (startDate && endDate) {
            where.updatedAt = {
                [Op.between]: timestampFormat(startDate, endDate)
            };
        }

        return this.model.findAndCountAll({
            offset: (page - 1) * pageSize,
            limit: pageSize,
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
     * @description 获取链接详情
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
            this.message.param('无效的id');
        }
        item = item.toJSON();
        item.tag = await tagService.getItem({ id: item.tagId });
        return item;
    }

     /**
     * @description 创建链接
     * @param {object} body 
     * @param {string} body.title
     * @param {string} body.url
     * @param {string} body.description
     * @param {number} body.tagId
     * @param {array} body.keyword
     * @returns 
     */
    async create(body = {}) {
        const data = {
            title: body.title,
            url: body.url,
            description: body.description,
            keyword: body.keyword,
            tagId: body.tagId
        };
        // TODO:判断tagId是否为二级标签
        return this.model.create(data)
            .catch((err) => {
                if (err instanceof UniqueConstraintError) {
                    this.message.param('该链接已存在!');
                } else {
                    throw(err);
                }
            });
    }

    /**
     * @description 更改链接
     * @param {object} body 
     * @param {number} body.id
     * @param {number} body.tagId
     * @param {string} body.title
     * @param {string} body.url
     * @param {string} body.description
     * @param {array} body.keyword
     * @returns 
     */
    update(body = {}) {
        const data = filterUndef({
            tagId: body.tagId,
            title: body.title,
            url: body.url,
            description: body.description,
            keyword: body.keyword
        });
        const where = {
            id: body.id
        };
        console.log(data);
        return this.model.update(data, { where })
            .catch((err) => {
                if (err instanceof UniqueConstraintError) {
                    this.message.param('该链接已存在!');
                } else {
                    throw(err);
                }
            });
    }

    /**
     * @description 删除链接
     * @param {object} query 
     * @param {number} query.id 
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


validate(LinkService, 'create', require('../../validator/link/create'));

validate(LinkService, 'destroy', require('../../validator/common/id'));

validate(LinkService, 'update', require('../../validator/link/update'));

validate(LinkService, 'getItem', require('../../validator/common/id'));

module.exports = new LinkService();