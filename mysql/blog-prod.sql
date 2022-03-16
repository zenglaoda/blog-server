-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2022-03-13 04:02:49
-- 服务器版本： 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- 表的结构 `article`
--

CREATE TABLE `article` (
  `id` int(11) NOT NULL COMMENT '文章id',
  `title` varchar(60) NOT NULL COMMENT '文章标题',
  `tagId` int(11) NOT NULL COMMENT '标签id',
  `description` varchar(300) DEFAULT NULL COMMENT '文章描述',
  `content` text NOT NULL COMMENT '文章内容',
  `status` char(1) NOT NULL DEFAULT '2' COMMENT '文章状态1.完成 2.草稿 ',
  `keyword` varchar(300) NOT NULL COMMENT '文章关键字，便于搜索引擎收录',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `article`
--

INSERT INTO `article` (`id`, `title`, `tagId`, `description`, `content`, `status`, `keyword`, `createdAt`, `updatedAt`) VALUES
(1, 'es5中实现继承的几种方式', 2, 'js继承相关笔记，参考自《javascript高级程序设计》', '# js继承\n\njs 中6中常见的继承方式\n\n## 原型链继承\n\n```javascript\nfunction SuperType() {\n    this.colors = [''red'', ''blue'', ''green''];\n}\nfunction SubType() {}\n\nSubType.prototype = new SuperType();\nvar instance1 = new SubType();\ninstance1.color.push(''black'');\ninstance1.color // ["red", "blue", "green", "black"];\n\nvar instance2 = new SubType();\ninstance2.color // ["red", "blue", "green", "black"];\n```\n  \n>   存在的问题:\n> - 原型上的属性在所有实例之间共享\n> - 在创建子类型的实例时，不能向超类型的构造函数传递参数\n\n\n## 借用构造函数继承\n\n```javascript\nfunction SuperType(name) {\n    this.name = name;\n    this.sayName = function(){\n        console.log(this.name)\n    }\n}\nfunction SubType(age, name) {\n    SuperType.call(this, name);\n    this.age = age;\n}\n```\n> 存在的问题:\n> - 无法避免构造函数模式存在的问题————方法都在构造函数中定义，因此函数无法复用。\n> - 子类型的实例无法继承超类型原型中定义的方法与属性\n\n\n## 组合继承\n\n```javascript\nfunction SuperType(name) {\n    this.name = name;\n}\nSuperType.prototype.sayName = function sayName() {\n    console.log(this.name)\n}\nfunction SubType(age) {\n    SuperType.call(this, name);\n    this.age = age;\n}\nSubType.protoType = new SuperType();\n```\n> 存在的问题:\n> - 调用两次超类型构造函数,导致子类型的原型与子类型的实例上都各自有相同的name属性，然后最终实例上的name属性，屏蔽了原型上的name属性。\n\n\n## 原型式继承\n\n```javascript\nfunction object(obj) {\n    function F() {}\n    F.prototype = obj;\n    return new F();\n}\nvar pro = {list: [], name: '''' };\nvar o = object(pro);\no.name = ''Rob''; // 在实例上添加一个name属性，屏蔽了原型上的name属性\no.list.push(''jane'');\nconsole.log(o.name) // Rob\nconsole.log(pro.name) // ''''\nconsole.log(o.list === pro.list) // true  [''Rob'']\n```\n\n>   es5通过Object.create方法规范化了原型式继承，该方法接受两个参数。\n> - 参数一：用作新对象原型的对象\n> - 参数二：为新对象定义多个额外属性的配置对象，Object.defineProperties方法的第二个参数相同\n\n> 存在的问题: 原型上的属性在所有实例中共享 \n\n## 寄生式继承\n\n```javascript\n```\n\n## 寄生组合式继承\n\n```javascript\n```\n', '2', 'js继承，组合继承，寄生继承，寄生组合式继承，原型链继承，原型式继承，借用构造函数继承', '2005-03-18 01:58:31', '2021-04-19 15:11:37'),
(2, 'BFC(Block Formatting context)', 9, '介绍产生BFC的条件，BFC的作用', '## BFC 是什么?\n> BFC是一个独立的布局环境，BFC内部的元素布局与外部互不影响\n\n## 常见产生 BFC 的 情况?\n- 浮动的元素 float属性值: left | right\n- 绝对定位的元素 position: absoute | fixed | sticky \n- display属性值为: flex | inline-flex | inline-block | flow-root, 表格相关属性如(table-cell, table-caption)\n- overflow: auto | scroll | hidden\n\n详情参考: [MDN 产生BFC的条件](https://developer.mozilla.org/zh-CN/docs/Web/Guide/CSS/Block_formatting_context)\n\n## BFC 的应用\n- 解决外边距折叠\n- 解决高度塌陷\n- 两栏布局([CSS深入理解流体特性和BFC特性下多栏自适应布局](https://www.zhangxinxu.com/wordpress/2015/02/css-deep-understand-flow-bfc-column-two-auto-layout/))\n\n\n\n## 参考文章\n1. [MDN 产生BFC的条件](https://developer.mozilla.org/zh-CN/docs/Web/Guide/CSS/Block_formatting_context)\n2. [BFC 的应用](https://zhuanlan.zhihu.com/p/127187654)\n3. [CSS深入理解流体特性和BFC特性下多栏自适应布局](https://www.zhangxinxu.com/wordpress/2015/02/css-deep-understand-flow-bfc-column-two-auto-layout/)', '1', 'bfc, block formatting context, 块级格式化上下文', '2005-03-18 01:58:31', '2021-05-19 14:08:00'),
(3, 'js 对象的原始类型值', 10, '介绍 Symbol.toPrimitive 属性的作用，js对象是如何进行数据运算，ECMA 对 toPrimitive 操作的如何定义', '> js 对象在某些情况需要转化成非对象数据类型，也就是原始数据类型。在不同的情景下，对象可能被转换成不同的原始数据。\n\n\n## 通过 Symbol.toPrimitive 属性自定义获取对象的原始类型值\n\n对于实现了 Symbol.toPrimitive 方法的对象，在进行原始数据类型转化时，会根据当前的执行环境给 Symbol.toPrimitive 方法传递 \n"default, string, number" 这个三个字符串参数中的任意一个计算其原始值。\n\n目前已知实现了 Symbol.toPrimitive 方法的对象有 Date, Symbol对象。\n\n参考于 [阮一峰 ES6-Symbol: 对象的 Symbol.toPrimitive 方法](https://es6.ruanyifeng.com/#docs/symbol)\n\n\n## 获取对象原始类型值的步骤\n\n参考于 [ECMAScript7规范中的ToPrimitive抽象操作](https://segmentfault.com/a/1190000016325587)\n\n\n## preferredType 在不同情景下的值\n\npreferredType 参数在不同的情景下所得到的值是不一样的，所以获取到的对象的原始类型值也可能是不一样的，这取决于当前执行的操作。\n\n```javascript\n    Array.prototype[Symbol.toPrimitive] = function (hint) {\n        console.log(hint);\n    }\n    Number([]) // hint => number\n    + [] // hint => number \n    [] + 0 // hint => default\n    [] - 0 // hint => number\n```\n\npreferredType 参数值具体参考 [ECMA 国际规格文件](http://www.ecma-international.org/ecma-262/7.0/#sec-addition-operator-plus-runtime-semantics-evaluation) 该规格文件中描述了 ECMA 语法及其实现方法\n\n', '1', 'toPrimitive, Symbol.toPrimitive, 原始类型值', '2005-03-18 01:58:31', '2021-06-07 15:29:45'),
(4, '相等运算符比较规则', 10, '介绍相等运算符的执行规则', '## 比较规则\n\n1. 如果x不是正常值（比如抛出一个错误），中断执行。\n2. 如果y不是正常值，中断执行。\n3. 如果Type(x)与Type(y)相同，执行严格相等运算x === y。\n4. 如果x是null，y是undefined，返回true。\n5. 如果x是undefined，y是null，返回true。\n6. 如果Type(x)是数值，Type(y)是字符串，返回x == ToNumber(y)的结果。\n7. 如果Type(x)是字符串，Type(y)是数值，返回ToNumber(x) == y的结果。\n8. 如果Type(x)是布尔值，返回ToNumber(x) == y的结果。\n9. 如果Type(y)是布尔值，返回x == ToNumber(y)的结果。\n10. 如果Type(x)是字符串或数值或Symbol值，Type(y)是对象，返回x == ToPrimitive(y)的结果。\n11. 如果Type(x)是对象，Type(y)是字符串或数值或Symbol值，返回ToPrimitive(x) == y的结果。\n12. 返回false。\n\n对于 ToPrimitive 操作,可参考 <<js 对象的原始类型值>> 一文\n\n参考于 [阮一峰: 读懂 ECMAScript 规格](https://www.ruanyifeng.com/blog/2015/11/ecmascript-specification.html)\n', '1', '==，相等运算符, 读懂ECMA 规格文件', '2005-03-18 01:58:31', '2021-06-07 15:34:36'),
(5, 'XSRF', 13, '介绍跨站请求伪造攻击特点，以及基本的规避措施', '> XSRF: 全称是跨站点请求伪造 Cross-site request forgery\n\n## 攻击细节\n\n> 由于 HTTP 协议是无状态协议，不能很好的存储用户状态，为此引入了 Cookie, Cookie 可以在本地浏览器保存一小块数据信息。因此大都网站\n使用 Cookie 保存用户的登录状态。在下一次向签发 Cookie 的服务器发送请求时，浏览器默认会将 cookie 数据添加到请求首部。\n攻击者通过一些技术手段欺骗用户的浏览器去访问一个自己曾经认证过的网站并运行一些操作（如发邮件，发消息，甚至财产操作如转账和购买商品）。由于浏览器曾经认证过，所以被访问的网站会认为是真正的用户操作而去运行。这利用了web中用户身份验证的一个漏洞：简单的身份验证只能保证请求发自某个用户的浏览器，却不能保证请求本身是用户自愿发出的。\n\n## 攻击条件\n\n1. 攻击者主要依赖于网站使用 Cookie 保存登录状态，Cookie 会自动随请求一起发送到服务器的特点。\n2. form 表单不存在跨域\n\n## 防御措施\n\n1. 检查 referer 字段\nHTTP头中有一个Referer字段，这个字段用以标明请求来源于哪个地址。在处理敏感数据请求时，通常来说，Referer字段应和请求的地址位于同一域名下。\n\n2. 添加校验token\n\n3. 通过给 cookie 设置 SameSite: Lax 或 SameSite: strict\n\n\n## 参考资料\n- [百度百科: 跨站请求伪造](https://baike.baidu.com/item/%E8%B7%A8%E7%AB%99%E8%AF%B7%E6%B1%82%E4%BC%AA%E9%80%A0/13777878?fromtitle=CSRF&fromid=2735433&fr=aladdin)\n\n- [阮一峰: Cookie 的 SameSite 属性](http://www.ruanyifeng.com/blog/2019/09/cookie-samesite.html)', '1', 'XSRF, 跨站请求伪造', '2005-03-18 01:58:31', '2021-06-08 14:47:45'),
(6, 'XSS', 13, '网站安全防护，XSS攻击的特点，与防御措施', '## 大纲\n1. 攻击特点\n2. 如何防范: 对用户输入进行转义, 注意innerHTML的使用, https 协议下内容安全政策(CSP: Content Safe Policy) 头字段的设置\n\n## 参考资料\n- [百度百科: XSS 攻击](https://baike.baidu.com/item/XSS%E6%94%BB%E5%87%BB/954065?fr=aladdin)', '1', 'XSS，跨站脚本攻击，web 攻击，', '2005-03-18 01:58:31', '2021-06-23 14:55:12'),
(7, 'cookie', 14, '介绍 cookie 相关的信息', '## 知识点\n1. cookie 的含义及其作用\n2. 客户端如何读写 Cookie (path, domain, expires)\n3. 服务端如何读写 Cookie (path, domain, Expires, Max-age, httpOnly, secure, Samesize: Lax | strict | None)\n4. 跨域请求如何发送 Coookie。客户端如何设置 XMLHTTRequest, 服务端如何设置 Access-Control-Allow-Origin 才能接受签发Cookie\n5. 一级域名相同，二级域名不同如何共享 Cookie, 服务端可以设置Cookie时指定domain, 或者客户端二级域名网站同时设置 document.domain\n\n## document.domain\ndocument.domain 可用于设置一级域名相同二级域名不同的网页间共享 cookie\n\n参考于 [阮一峰: 浏览器同源政策及其规避方法](http://www.ruanyifeng.com/blog/2016/04/same-origin-policy.html)\n\n\n## document.cookie\ndocument.cookie 用于本地浏览器设置或读取 cookie.\n\ndocument.cookie 设置 cookie 时，若 domain 设置的不是当前路径包含的域名或子域名，则会忽略本次设置\n\n\n## 参考资料\n- [MDN: HTTP Cookies, Cookie 相关介绍](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Cookies)\n- [MDN: document.cookie,客户端设置 cookie 可使用的相关配置属性](https://developer.mozilla.org/zh-CN/docs/Web/API/Document/cookie)\n- [MDN: Set-Cookie, 服务端设置 cookie 可使用的相关配置属性](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Set-Cookie)\n- [阮一峰: Cookie 的 SameSite 属性](http://www.ruanyifeng.com/blog/2019/09/cookie-samesite.html)\n- [阮一峰: 跨域资源共享 CORS 详解, AJAX 跨域请求中 cookie 的表现与设置](http://www.ruanyifeng.com/blog/2016/04/cors.html)', '1', 'cookie, cookie的详细介绍与使用', '2005-03-18 01:58:31', '2021-06-08 15:19:30'),
(8, '实现 bind 方法', 2, '实现 bind 方法，Function.prototype.bind', '## 实现细节\nbind 方法的第一个参数用于指定返回函数的this, 剩余参数依次作为返回函数的参数\n\n```javascript\n\nFunction.prototype.bind = function() {\n    const fn = this;\n    const context = arguments[0];\n    const rest = Array.prototype.slice.call(arguments, 1);\n    return function() {\n        const args = Array.prototype.slice.call(arguments);\n        return fn.apply(context, rest.concat(args));\n    }\n}\n\n```', '1', 'bind, 实现 bind方法', '2005-03-18 01:58:31', '2021-06-08 15:35:50'),
(9, '事件相关知识点', 15, 'event, addEventListener,事件冒泡，事件委托', '## table of content\n1. 如何自定义事件\n2. 事件流处理的4个阶段，注意当事件流正处于目标阶段时，目标元素所注册的冒泡阶段事件，捕获阶段事件会同时发生。\n3. addEventListener, removeEventListener 方法的第三个参数的意义\n4. 事件委托的原理是利用了事件冒泡\n\n## 自定义事件\n```javascript\nvar lookEvent = new Event(''look'', {\n    bubbles: true,\n    cancelBubble: true,\n})\ndocument.body.dispatch(lookEvent)\n```\n\n## eventPhase 事件阶段\n```\n    NONE -> 0\n    CAPTURING_PHASE -> 1\n    AT_TARGET -> 2\n    BUBBLING_PHASE -> 3\n```', '1', 'event, addEventListener,事件冒泡，事件委托', '2005-03-18 01:58:31', '2021-06-15 13:51:54'),
(10, '常见状态码及其含义', 16, 'http 状态码', '\n## 状态码的类别\n- 1xx: 信息性状态码, 接收的请求正在处理\n- 2xx: 成功状态码, 请求正常处理完毕\n- 3xx: 重定向状态码, 需要进行附加操作已完成请求(通常是将本次请求方法转成GET再次发起请求)\n- 4xx: 客户端错误状态码, 服务器无法处理请求\n- 5xx: 服务器错误状态码, 服务器处理请求出错\n\n## 2xx 状态码\n- 200 (OK): 表示客户端发来的请求在服务器端被正常处理了\n- 204 (No Content): 该状态码代表服务器接收的请求已被成功处理，但在返回的响应报文中不包含实体的主体部分。也不允许返回任何实体的主体。\n- 206 (Partial Content): 该状态码表示客户端进行了范围请求，服务器成功的执行了这部分的GET请求。响应报文中包含由 Content-Range 指定范围的实体内容\n\n\n## 3XX 状态码\n> 当301, 302, 303 响应状态码返回时，几乎所有的浏览器都会把 POST 改成 GET, 并删除请求报文内的主体，之后请求会自动再次发送。\n\n- 301 (Move Permanently): 永久性重定向，该状态码表示请求的资源已经被分配了新的URI, 以后应该使用资源现在所指的URI\n- 302 (Found): 临时性重定向\n- 303 (See Other)\n- 304 (Not Modified): 该状态码表示客户端发送附带条件的请求时，服务器允许请求访问资源，但因发生请求未满足条件的情况后直接返回 304 (服务器资源未改变, 可直接使用客户端未过期的缓存)，不包含任何响应的主体部分。\n- 307 (Temporary Redirect): 临时重定向\n\n> 附带条件的请求是指采用 GET 方法的请求报文中包含 If-Match, If-Modified-Since, If-None-Match,If-Range,If-Unmodified-Since 中任一首部\n\n## 4xx 状态码\n> 4xx 状态码的响应结果表明客户端是发生错误的原因所在\n\n- 400 (Bad Request): 该状态码表似乎报文请求中存在语法错误(一般是请求参数格式错误)。\n- 401 (Unauthorized): 未授权，需要进行授权确认。\n- 403 (Forbidden): 该状态码表明对请求资源的访问被服务器拒绝了(一般表示不允许访问)\n- 404 (Not Found): 该状态码表明服务器上无法找到请求的资源(一般是请求方法错误，或者地址错误)\n- 405 (Method Not Allowed): 当前请求的 URL 不支持这个请求方法 \n- 408 (Request Timeout): 处理这条请求所需的时间过长\n\n## 5xx 状态码\n> 5xx 的响应结果表明服务器本身出现了错误\n\n- 500 (Internet Server Error): 该状态码表明服务器在执行请求时发生了错误(一般是代码出现bug)\n- 501 (Not Implemented): 客户端发起的请求超出服务器的能力范围\n- 503 (Service Unavaible): 该状态码表明服务器暂时处于超负荷或正在进行停机维护, 现在无法处理请求\n- 504 (Gateway Timeout): 响应来自一个网关或代理，它们在等待零一服务器对其请求进行响应时超时了\n\n## 参考资料\n- << HTTP 权威指南 >>\n- << 图解 HTTP >>', '1', 'http 状态码', '2005-03-18 01:58:31', '2021-06-15 15:14:43'),
(11, 'setTimeout定时器', 17, '介绍setTimeout，setInterval定时器， 以及定时器的最小延迟时间，最大延时。以及它们之间的区别', '## 最小延迟时间\nsetTimeout(function[, delay]) delay 含义表示的是最小延迟时间，具体原因参考事件循环\n\n```javascript\n  var timestamp;\n  var count = 0;\n  var timer = setInterval(() => {\n    var now = Date.now();\n    if (timestamp) {\n      console.log(`执行次数:${count};间隔:${now - timestamp} ms`);\n    }\n    timestamp = now;\n\n    count++;\n    if (count > 100) {\n      clearInterval(timer);\n    }\n  }, 0);\n```\n\n## 最大延时值\nIE,  Chrome, Safari, Firefox 在内的浏览器其内部以32位带符号整数存储延时。这就会导致如果一个延时(delay)大于 2147483647(2**31-1) 毫秒 (大约24.8 天)时就会溢出，导致定时器将会被立即执行。\n\n\n## 实现一个 0ms 延时的定时器\n- [MDN: 使用 postMessage 实现 0ms 延时的定时器](https://dbaron.org/log/20100309-faster-timeouts)\n\n## 参考资料\n- [MDN: setTimeout](https://developer.mozilla.org/zh-CN/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout)\n\n- [微信公众号: 为什么要用 setTimeout 模拟 setInterval ](https://mp.weixin.qq.com/s/_BdnoOJPqtCRYnjL_gA_Gw)', '1', '定时器,setTimeout,setInterval,最小延迟时间，最大延时\n ', '2005-03-18 01:58:31', '2021-06-21 14:37:57'),
(12, 'throttle,debounce (节流与防抖)', 17, 'throttle，debounce ，节流，防抖的实现', '## throttle\n```javascript\n/**\n * @description 节流\n * @param {number} delay 延迟毫秒数\n * @param {function} callback 回调函数\n * @param {boolean} [immediate=true] 是否立即执行一次\n * @param {boolean} [trailing=false] 是否尾随执行一次\n * @returns {function}\n */\nfunction throttle(delay, callback, immediate = true, trailing = true) {\n    let timeID;\n    let lastExec = 0;\n    return function wrapper(...args) {\n        let that = this;\n        let elapsed = Date.now() - lastExec;\n        function exec() {\n            callback.apply(that, args);\n            lastExec = Date.now();\n            timeID = setTimeout(reset, delay);\n        }\n        function reset() {\n            timeID = undefined;\n        }\n        if (timeID) {\n            clearTimeout(timeID);\n        }\n        if (immediate && !timeID) {\n            exec()\n            return;\n        } \n        if (elapsed > delay) {\n            exec();\n        } else {\n            timeID = setTimeout(trailing ? exec : reset, delay - elapsed)\n        }\n    }\n}\n```\n\n## debounce\n\n```javascript\n/**\n * @description 防抖\n * @param {number} delay 延迟毫秒数\n * @param {function} callback 回调函数\n * @param {boolean} [immediate=false] 是否立即执行一次\n * @returns {function}\n */\nfunction debounce(delay, callback, immediate = false) {\n    let timeID;\n    return function wrapper(...args) {\n        let that = this;\n        function reset() {\n            timeID = undefined;\n        }\n        function exec() {\n            callback.apply(that, args);\n        }\n        if (timeID) {\n            clearTimeout(timeID);\n        }\n        if (immediate && !timeID) {\n            exec();\n            timeID = setTimeout(reset, delay);\n        } else {\n            timeID = setTimeout(() => {\n                exec();\n                reset();\n            }, delay);\n        }\n    }\n}\n```\n', '1', 'throttle，debounce ，节流，防抖', '2005-03-18 01:58:31', '2021-06-21 14:39:25'),
(13, 'instanceof 操作符实现原理 ', 17, 'instanceof 操作符实现原理，根据ECMA规格文件实现instanceof操作符功能', '# instanceof 操作符\nv instanceof target\n\n> instanceof 运算符用于检测构造函数的 prototype 属性是否出现在某个实例对象的原型链上。\n\n## 注意事项\n1. instanceof 和多全局对象\n2. 对象的 Symbol.hasInstance 属性\n3. 类型错误将导致抛出错误(target 不是 object, 不可调用)\n4. 对 Function.prototype.bind 方法返回的函数使用改操作符\n\n## Symbol.hasInstance\n> Symbol.hasInstance 用于判断某对象是否为某构造器的实例。因此你可以用它自定义 instanceof 操作符在某个类上的行为。\n\n```javascript\nvar say = {\n  [Symbol.hasInstance](param) {\n    return param === ''say'';\n  }\n};\n1 instanceof say // false\n''say'' instanceof say // true\n```\n\n## 实现\n以下代码未考虑 Funtion.prototype.bind 的情况，因[[BoundTargetFunction]]的缘故无法模拟\n\n```javascript\n  function isInstanceof(v, target) {\n    function isObject(param) {\n        return param && (typeof param === ''object'' || typeof param == ''function'');\n    }\n    function isDef(param) {\n        return param !== null && param !== undefined;\n    }\n\n    if (!isObject(target)) {\n        throw new TypeError(''target is not an object'')\n    }\n    const instOfHandler = target[Symbol.hasInstance];\n    if (isDef(instOfHandler)) {\n        return Boolean(instOfHandler.call(target, v));\n    }\n    if (typeof target !== ''function'') {\n        throw new TypeError(''target is not callable'')\n    }\n    if (!isObject(v)) {\n        return false;\n    }\n    let proto = target.prototype;\n    if (!isObject(proto)) {\n        throw new TypeError(''target.prototype is not an object'')\n    }\n    let p = Object.getPrototypeOf(v);\n    while (true) {\n        if (p == null) {\n            return false;\n        }\n        if (p === proto) {\n            return true;\n        }\n        p = Object.getPrototypeOf(p);\n    }\n  }\n```\n\n## 参考资料\n- [MDN: instanceof](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/instanceof)\n\n- [ECMA 规格文件: instanceof](https://262.ecma-international.org/10.0/#sec-instanceofoperator)\n\n- [MDN: Symbol.hasInstance](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Symbol/hasInstance)\n', '1', 'instanceof 操作符实现原理', '2005-03-18 01:58:31', '2021-06-21 14:41:39'),
(14, '用div模拟textarea', 17, 'contenteditable的使用，用div模拟textarea', '## 注意点\n1. 设置了 contentediable 的元素，可以粘贴任何包含格式的文件，textarea 的内容只能是文字。\n2. user-modify 属性存在 bug, 计划将移除该属性\n3. onpaste 是一个非标准的规范，但是几乎所有浏览器都支持该事件\n\n## contenteditable 可使用的属性值\n1. true\n2. false\n3. caret(实验功能)\n4. events(实验功能)\n5. plaintext-only(实验功能): 限制只能输入文本\n6. typing(实验功能)\n\n## css 实现\n方法一: 设置 dom 属性 contenteditable = plaintext-only\n方法二: 设置 css 属性 user-modify: read-write-plaintext-only\n\n## js 实现\n```javascript\n  var oEditor = document.querySelector(''#editor'');\n\n  function getText(item) {\n      console.log(item);\n      item.getAsString(function(text) {\n          console.log(text);\n      });\n  }\n  function onpaste(event) {\n      // 获取剪贴板内容方式一\n      let paste = (event.clipboardData).getData(''text'');\n      // 获取剪贴板内容方式二\n      const items = event.clipboardData.items;\n      Array.from(items, (item, index) => {\n          getText(item);\n      });\n  }\n  oEditor.onpaste = onpaste;\n```\n\n\n## 参考资料\n- [caniuse: user-modify](https://www.caniuse.com/?search=user-modify)\n- [caniuse: contenteditable](https://www.caniuse.com/?search=contenteditable)\n- [MDN: Element paste 事件](https://developer.mozilla.org/zh-CN/docs/Web/API/Element/paste_event)', '1', 'contenteditable的使用，用div模拟textarea', '2005-03-18 01:58:31', '2021-06-21 14:43:57'),
(15, '跨域解决方案(cross-domain)', 17, '跨域解决方案,cross-domain, cookie,IndexDB,LocalStorage, DOM, AJAX跨源解决方案', '\n## 产生跨域的原因\n浏览器的安全基石是"同源政策"。\n\n## same-origin policy 同源政策\n1. 目的: 保证用户信息安全。防止信息被盗用\n2. 含义: 协议，域名，端口相同\n3. 限制范围: Cookie, LocalStorage, IndexDB无法读取; DOM无法获取;  AJAX不能发送\n\n## 解决跨域通信\n### CORS (cross-origin source share)\n\n### postMessage\n\n### jsonp\n实现原理:\n1. script 标签不受同源策略的影响\n2. script 标签加载的内容会作为 javascript 脚本直接运行\n\n``` javascript\nfunction addScriptTag(src) {\n  var script = document.createElement(''script'');\n  script.setAttribute("type","text/javascript");\n  script.src = src;\n  document.body.appendChild(script);\n}\n\nwindow.onload = function () {\n  addScriptTag(''http://example.com/ip?callback=foo'');\n}\n\nfunction foo(data) {\n  console.log(''Your public IP address is: '' + data.ip);\n};\n```\n\n\n### 片段标识符\n父子窗口通过片段标识符传递数据，通过监听 onhashchange 获取数据\n\n### window.name\n通过子窗口设定 window.name 属性之后，重新导航到一个父窗口同源的网页。然后父窗口通过 contentWindow.name 读取子窗口的name属性。通信时需要监听window.name 属性\n\n### WebSocket\n全双工通信不受"同源政策"的影响\n\n### nginx\n\n\n\n\n\n## 解决 Cookie 跨源\n### documnet.domain\n当两个网页一级域名相同，二级域名不同的时候，两个网页同时设置相同的document.domain 可进行cookie的共享\n\n### Cookie 的 domain 配置\n服务端或客户端设置 Cookie 时, 指定 domain 选项\n\n\n\n\n## 解决 DOM 跨源无法读取\n当两个网页一级域名相同，二级域名不同的时候，两个网页同时设置相同的document.domain 可读取 DOM\n\n\n\n\n\n## 参考资料\n- [阮一峰: 浏览器同源政策及其规避方法](https://www.ruanyifeng.com/blog/2016/04/same-origin-policy.html)\n\n- [阮一峰: 跨域资源共享 CORS 详解](http://www.ruanyifeng.com/blog/2016/04/cors.html)', '1', '跨域解决方案,cross-domain, cookie,IndexDB,LocalStorage, DOM, AJAX跨源,', '2005-03-18 01:58:31', '2021-06-23 14:38:02');

-- --------------------------------------------------------

--
-- 表的结构 `link`
--

CREATE TABLE `link` (
  `id` int(11) NOT NULL COMMENT '链接id',
  `title` varchar(60) NOT NULL COMMENT '分享的标题',
  `tagId` int(11) NOT NULL COMMENT '标签Id',
  `description` varchar(300) NOT NULL COMMENT '内容描述',
  `url` varchar(100) NOT NULL COMMENT '链接地址',
  `keyword` varchar(300) NOT NULL COMMENT '关键词',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='链接表';

--
-- 转存表中的数据 `link`
--

INSERT INTO `link` (`id`, `title`, `tagId`, `description`, `url`, `keyword`, `createdAt`, `updatedAt`) VALUES
(1, '通过自定义vue指令实现前端曝光埋点', 5, '数据来源微信公众号：小生方勤', 'https://mp.weixin.qq.com/s/zFZI5uDIa-eH6wffhqL3Fg', '数据埋点，数据曝光，vue自定义指令，记录用户行为', '2021-04-21 15:23:09', '2021-04-21 15:23:09'),
(2, '神奇的 CSS 映射鼠标位置，实现通过鼠标移动控制页面元素效果', 7, '文章来源微信公众号:iCSS前端趣闻', 'https://mp.weixin.qq.com/s/2aeyglJHuTutE8jZ1XgRuA', 'css动画，跟随鼠标移动，跳动粒子', '2021-04-21 15:26:53', '2021-04-21 15:26:53'),
(3, '阿里巴巴P6前端面试经验分享', 8, '阿里巴巴P6前端面试经验，个人进阶指南，进阶方向,需要掌握的知识点', 'https://zhuanlan.zhihu.com/p/145079928', '面试经验，面试技巧，阿里巴巴p6要求，个人进阶指南，进阶方向，需要掌握的知识点', '2021-04-21 15:36:30', '2021-04-21 15:36:30'),
(4, '若川知乎问答：2年前端经验，做的项目没什么技术含量，怎么办？', 8, '如何写好简历，简历上应该重点写些什么', 'https://mp.weixin.qq.com/s/PY02WfJb96xXuF5OR5DDmQ', '如何写好简历', '2021-06-30 14:05:00', '2021-06-30 14:05:00'),
(5, '我在阿里招前端，我该怎么帮你？', 8, '讲解了前端开发者每个阶段需要掌握的知识图谱，面试的大致方向，个人的进阶方向', 'https://mp.weixin.qq.com/s/cFRqz6-vYhBGV8sI26NbTQ', '面试知识图谱，面试知识点，职业规划，进阶方向', '2021-06-30 15:32:06', '2021-06-30 15:32:06');

-- --------------------------------------------------------

--
-- 表的结构 `tag`
--

CREATE TABLE `tag` (
  `id` int(11) NOT NULL COMMENT '标签id',
  `pid` int(11) NOT NULL COMMENT '父级标签id',
  `name` varchar(30) NOT NULL COMMENT '标签名',
  `description` varchar(300) NOT NULL COMMENT '标签描述',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签';

--
-- 转存表中的数据 `tag`
--

INSERT INTO `tag` (`id`, `pid`, `name`, `description`, `createdAt`, `updatedAt`) VALUES
(1, 0, '面试', '面试相关记录', '2021-04-19 14:02:29', '2021-04-19 14:02:29'),
(2, 1, 'js基础', '', '2021-04-19 14:02:58', '2021-04-19 14:02:58'),
(3, 1, 'js 继承', 'js 实现继承的几种方法，面试常见的如寄生组合式继承，es6的class继承；以及这两种继承之间的区别。', '2021-04-19 15:09:05', '2021-04-19 15:09:05'),
(4, 0, '业务开发', '记录业务开发中的一些知识点，问题，以及解决方法', '2021-04-21 14:59:34', '2021-04-21 14:59:34'),
(5, 4, '数据埋点', '通过记录用户在网页上触发的一系列事件，记录用户行为数据，根据数据挖掘信息', '2021-04-21 15:20:31', '2021-04-21 15:20:31'),
(6, 0, 'css', '记录css相关知识点', '2021-04-21 15:24:05', '2021-04-21 15:24:05'),
(7, 6, 'animation', '记录css相关动画知识，动画效果', '2021-04-21 15:24:46', '2021-04-21 15:24:46'),
(8, 1, '面试经验与技巧', '记录面试相关的经验，面试技巧', '2021-04-21 15:34:09', '2021-04-21 15:34:09'),
(9, 1, 'css 基础', 'css 相关的基础面试题', '2021-05-19 14:04:09', '2021-05-19 14:04:09'),
(10, 12, 'ECMA', '记录 js 语法相关的笔记', '2021-06-07 15:01:11', '2021-06-07 15:28:46'),
(11, 10, 'toPrimitive', '对象的原始类型值究竟是如何规定的', '2021-06-07 15:02:18', '2021-06-07 15:02:18'),
(12, 0, 'javascript', 'javascript 相关知识点', '2021-06-07 15:28:25', '2021-06-07 15:28:25'),
(13, 1, 'Web攻击', '介绍 常见  web 攻击手段', '2021-06-07 15:42:04', '2021-06-07 15:42:04'),
(14, 12, 'cookie', '介绍 Cookie 相关知识点', '2021-06-08 14:57:51', '2021-06-08 14:57:51'),
(15, 12, 'event', '事件相关知识点', '2021-06-10 15:51:59', '2021-06-10 15:51:59'),
(16, 1, 'http', 'http相关知识点', '2021-06-15 15:13:48', '2021-06-15 15:13:48'),
(17, 1, '面试题', '', '2021-06-21 14:33:44', '2021-06-21 14:33:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `link`
--
ALTER TABLE `link`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `url` (`url`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `article`
--
ALTER TABLE `article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章id', AUTO_INCREMENT=16;
--
-- 使用表AUTO_INCREMENT `link`
--
ALTER TABLE `link`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '链接id', AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签id', AUTO_INCREMENT=18;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
