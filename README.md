![logo](logo.svg)

# 喵喵出行移动端

#### 介绍

后端Cloud [Gitee](https://gitee.com/lovelinessmoe/MeowTravelSpring) [GitHub](https://github.com/lovelinessmoe/MeowTravelSpring)

前端VUE3 [Gitee](https://gitee.com/lovelinessmoe/MeowTravelVue) [GitHub](https://github.com/lovelinessmoe/MeowTravelVue)

移动端Flutter [Gitee](https://gitee.com/lovelinessmoe/MeowTravelFlutter) [GitHub](https://github.com/lovelinessmoe/MeowTravelFlutter)

内蒙古师范大学2019计算机科学技术学院曹顺淼毕业设计

基于Spring Boot的旅游路线以及酒店住宿推荐系统的设计与实现

涉及技术：SpringBoot+SpringCloud+SpingGateWay+NacOS+MySql+Mybatis+MybatisPlus+Redis+SpringSecurity OAuth2+JWT+⼜拍云OSS+百度地图API+VUE+Axios+Flutter+dio

项目描述：项⽬包含六个服务,分别是认证服务,⽹关服务,系统管理员服务,⽤户服务,⽀付服务以及百度地图服务;认证服务主要实现token⽣成与下发;⽹关服务实现应⽤的主要⼊⼝,对不同请求分发到不同微服务上,并且在请求时进⾏权限认证;系统管理员服务可以对⽤户,攻略,旅游团以及存在的酒店/景点信息进⾏管理,对系统⼤部分内容进⾏管理;⽤户服务有登录注册,浏览攻略,发布攻略,管理攻略,地点检索,获取推荐,个⼈信息修改;⽀付服务是对攻略的赞助后端服务;百度地图服务计⼊了⼏个百度地图API,还有推荐实现,系统主要通过基于⽤户的协同过滤算法给⽤户进⾏推荐

1. 采⽤分布式架构,使⽤SpingCloud作为系统基础,使⽤NacOS作为注册中⼼
2. 使⽤SpringGateWay+SpringSecurity作为系统鉴权以及服务分流,使⽤Redis作为资源服务器权限存储器
3. 使⽤Mybatis+MybatisPlus+Mysql作为系统持久层框架
4. 使⽤⼜拍云OSS作为攻略图⽚和⽤户头像存储器
5. 使⽤百度地图API给⽤户地图直观的展现
6. 前端使⽤VUE+ElementUI,使⽤Axios进⾏异步请求,使⽤VueX记录Token
7. 使⽤Redis对常⽤数据进⾏缓存,⽐如权限列表,字典信息以及需要⼤量计算的数据(地图⼈数
可视化)
8. 移动端使⽤Flutter开发,使⽤dio进⾏异步请求

- 功能模块：
    - 个人中心：可以查看并且修改个人资料信息。
    - 修改密码：根据旧密码，修改新的密码信息。
    - 我的订单：查看我在本网站订购的服务信息以及订购的状态。
    - 管理员通过用户名，密码登录本网站，对本网站的信息进行管理。
    - 用户统计：以地图形式统计出本网站在全国的所有省份的网站注册人数。
    - 注册用户：查看前台网站的注册用户信息，可以对其进行搜索查询，同时也可以进行添加，删除等操作。
    - 系统用户：对于后台登录的用户信息进行管理，可以添加用户信息，也可以修改删除，按名称查询用户信息。
