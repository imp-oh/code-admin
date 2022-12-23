# Express  ⚡

## 项目启动
```
  npm run serve
```

## 获取参数
```js
req.query
req.body,
req.params
```

## 文件目录

```
--| config
----| dbconfig.js  => 数据库配置
----| header.js => 请求头配置
----| index.js => 公共依赖
----| interceptor.js => 拦截器
----| routes.js => 路由配置
----| static.js => 静态配置
```



# 修改数据库
 config =>dbconfig.js 




## api文档 
```
官方配置地址 https://apidocjs.com/#params
其他教程 https://www.jianshu.com/p/7e1b057b047c/   https://www.jianshu.com/p/34eac66b47e3

项目terminal执行命令行：
  apidoc -i routes/ -o public/apidoc/

```


## 防止SQL注入
相关链接`https://www.cnblogs.com/rysinal/p/8350783.html`

### 方法一：使用escape()对传入参数进行编码：
```js
// 参数编码方法escape()有如下三个：
mysql.escape(param)
connection.escape(param)
pool.escape(param)

// 方法三： 使用escapeId()编码SQL查询标识符：
mysql.escapeId(identifier)
connection.escapeId(identifier)
pool.escapeId(identifier)

//方法四： 使用mysql.format()转义参数：
// 例如：
var userId = 1;
var sql = "SELECT * FROM ?? WHERE ?? = ?";
var inserts = ['users', 'id', userId];
sql = mysql.format(sql, inserts); // SELECT * FROM users WHERE id = 1

```


## 插件

```
https://blog.csdn.net/u013032599/article/details/106551333/   文件上传问题
```






# 加密使用方式
``` js

/** 生成密钥 */
  var key = new NodeRSA({ b: 1024 }); //生成512位秘钥
  key.setOptions({ encryptionScheme: 'pkcs1' })
  var pubkey = key.exportKey('pkcs8-public'); //导出公钥
  var prikey = key.exportKey('pkcs8-private'); //导出私钥

  console.log(pubkey)
  console.log('-------------------')
  console.log(prikey)





  var key = new NodeRSA({ b: 512 }); //生成512位秘钥
  var pubkey = key.exportKey('pkcs8-public'); //导出公钥
  var prikey = key.exportKey('pkcs8-private'); //导出私钥
  var pubKey = 'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIoqyekvHO20d0lnr82P5iNPgwvFbo4KG3asYtfofne+cJhTTomPTTohiIhvALtcAbT1+Mdc1ByW0qfddhJBgKMCAwEAAQ=='
  var priKey = 'MIIBVQIBADANBgkqhkiG9w0BAQEFAASCAT8wggE7AgEAAkEAiirJ6S8c7bR3SWevzY/mI0+DC8Vujgobdqxi1+h+d75wmFNOiY9NOiGIiG8Au1wBtPX4x1zUHJbSp912EkGAowIDAQABAkBrLAOQR8Ylr+0zWCUqyyrVSvC4ab12mepxpAfLuACZOk2r2sXqEJSO7rKot6fEFvQUSWGxofnOOq26MWzfOjlJAiEA19q/21mgryuUkmZwdE+oa4QslOWM8jkcVe1pZggFMscCIQCj3TG0TBXYDDUoVWYzNLslDDvZ6yFPiMJijrIW6m2nRQIhAJEWbQ0wcmwr2+KHzqCvhmI2Zozyusl5j81GFilJzMyzAiEAiuiDrhehnNgcZ+idDmNxEeLhCcatIkMIpYvZpFtuQRECIBGPkR84Fr4IMltf4iqpeMPX+eg6/OkYHxQeayi1Hgnz'
  var pubKey1 = new NodeRSA(pubKey, 'pkcs8-public'); //导入公钥
  var priKey1 = new NodeRSA(priKey, 'pkcs8-private'); //导入私钥
  const jia = pubKey1.encrypt('jiang', 'base64')
  console.log(jia)

  const jie = priKey1.decrypt(jia, 'utf8')
  console.log('---解密')
  console.log(jie)
```




```  
## 富文本

yarn add markdown    => 这个依赖可以解析和转换 html

使用方式 

const markdown = require("markdown").markdown;
markdown.toHTML(data[0].newstext)


## 自定义数据插入代码 
    onload: function() {
      var keyMap = {
        'Ctrl-S': function(cm) {
          var cursor = cm.getCursor();
          var selection = cm.getSelection();

          if (cursor.ch !== 0) {
            cm.setCursor(cursor.line, 0);
            cm.replaceSelection("````\n\n````" + selection);
            cm.setCursor(cursor.line, cursor.ch + 2);
          } else {
            cm.replaceSelection("````\n\n````" + selection);
          }
        }
      }

      this.addKeyMap(keyMap)
    }
```







# pkg 打包地址
```
打包命令 ： pkg -t win package.json

# 相关地址 
https://www.npmjs.com/package/pkg
https://www.yisu.com/zixun/182832.html
```

# pkg 打包遇到的问题
####  TypeError [ERR_INVALID_ARG_TYPE]: The &quot;path&quot; argument must be of type string. Received typ
```js

// 报错信息 TypeError [ERR_INVALID_ARG_TYPE]: The &quot;path&quot; argument must be of type string. Received typ
// 相关链接 https://www.codeee.top/web/2021-05-28/464.html
//  我们打包成pkg 报错，这个时候我们就找到【node_modules/express/lib/view.js】
// 添加一个 全局的    var _path = require('path');
// 在往下找到 105行左右  
// 将 var loc = resolve(root, name);   替换成 var loc = _path.resolve(root, name);

```  




# 状态码

100——客户必须继续发出请求
101——客户要求服务器根据请求转换HTTP协议版本
200——交易成功
201——提示知道新文件的URL
202——接受和处理、但处理未完成
203——返回信息不确定或不完整
204——请求收到，但返回信息为空
205——服务器完成了请求，用户代理必须复位当前已经浏览过的文件
206——服务器已经完成了部分用户的GET请求
300——请求的资源可在多处得到
301——删除请求数据
302——在其他地址发现了请求数据
303——建议客户访问其他URL或访问方式
304——客户端已经执行了GET，但文件未变化
305——请求的资源必须从服务器指定的地址得到
306——前一版本HTTP中使用的代码，现行版本中不再使用
307——申明请求的资源临时性删除
400——错误请求，如语法错误
401——请求授权失败
402——保留有效ChargeTo头响应
403——请求不允许
404——没有发现文件、查询或URl
405——用户在Request-Line字段定义的方法不允许
406——根据用户发送的Accept拖，请求资源不可访问
407——类似401，用户必须首先在代理服务器上得到授权
408——客户端没有在用户指定的饿时间内完成请求
409——对当前资源状态，请求不能完成
410——服务器上不再有此资源且无进一步的参考地址
411——服务器拒绝用户定义的Content-Length属性请求
412——一个或多个请求头字段在当前请求中错误
413——请求的资源大于服务器允许的大小
414——请求的资源URL长于服务器允许的长度
415——请求资源不支持请求项目格式
416——请求中包含Range请求头字段，在当前请求资源范围内没有range指示值，请求也不包含If-Range请求头字段
417——服务器不满足请求Expect头字段指定的期望值，如果是代理服务器，可能是下一级服务器不能满足请求
500——服务器产生内部错误
501——服务器不支持请求的函数
502——服务器暂时不可用，有时是为了防止发生系统过载
503——服务器过载或暂停维修
504——关口过载，服务器使用另一个关口或服务来响应用户，等待时间设定值较长
505——服务器不支持或拒绝支请求头中指定的HTTP版本




# redis 使用
var redis = require('redis');

var client = redis.createClient('6379', '127.0.0.1');

client.auth("password");
client.set('hello','This is a value');
client.expire('hello',10) //设置过期时间
client.exists('key') //判断键是否存在
client.del('key1')
client.get('hello');

 

//stirng
命令 行为 返回值 使用示例(略去回调函数)
set 设置存储在给定键中的值 OK set('key', 'value')
get 获取存储在给定键中的值 value/null get('key')
del 删除存储在给定键中的值(任意类型) 1/0 del('key')
incrby 将键存储的值加上整数increment incrby('key', increment)
decrby 将键存储的值减去整数increment decrby('key', increment)
incrbyfloat 将键存储的值加上浮点数increment incrbyfloat('key', increment)
append 将值value追加到给定键当前存储值的末尾 append('key', 'new-value')
getrange 获取指定键的index范围内的所有字符组成的子串 getrange('key', 'start-index', 'end-index')
setrange 将指定键值从指定偏移量开始的子串设为指定值 setrange('key', 'offset', 'new-string')
//list
命令 行为 返回值 使用示例(略去回调函数)
rpush 将给定值推入列表的右端 当前列表长度 rpush('key', 'value1' [,'value2']) (支持数组赋值)
lrange 获取列表在给定范围上的所有值 array lrange('key', 0, -1) (返回所有值)
lindex 获取列表在给定位置上的单个元素 lindex('key', 1)
lpop 从列表左端弹出一个值，并返回被弹出的值 lpop('key')
rpop 从列表右端弹出一个值，并返回被弹出的值 rpop('key')
ltrim 将列表按指定的index范围裁减 ltrim('key', 'start', 'end')

//set
命令 行为 返回值 使用示例(略去回调函数) sadd 将给定元素添加到集合 插入元素数量 sadd('key', 'value1'[, 'value2', ...]) (不支持数组赋值)(元素不允许重复)
smembers 返回集合中包含的所有元素 array(无序) smembers('key')
sismenber 检查给定的元素是否存在于集合中 1/0 sismenber('key', 'value')
srem 如果给定的元素在集合中，则移除此元素 1/0 srem('key', 'value')
scad 返回集合包含的元素的数量 sacd('key')
spop 随机地移除集合中的一个元素，并返回此元素 spop('key')
smove 集合元素的迁移 smove('source-key'dest-key', 'item')
sdiff 返回那些存在于第一个集合，但不存在于其他集合的元素(差集) sdiff('key1', 'key2'[, 'key3', ...])
sdiffstore 将sdiff操作的结果存储到指定的键中 sdiffstore('dest-key', 'key1', 'key2' [,'key3...])
sinter 返回那些同事存在于所有集合中的元素(交集) sinter('key1', 'key2'[, 'key3', ...])
sinterstore 将sinter操作的结果存储到指定的键中 sinterstore('dest-key', 'key1', 'key2' [,'key3...])
sunion 返回那些至少存在于一个集合中的元素(并集) sunion('key1', 'key2'[, 'key3', ...])
sunionstore 将sunion操作的结果存储到指定的键中 sunionstore('dest-key', 'key1', 'key2' [,'key3...])
//hash
命令 行为 返回值 使用示例(略去回调函数)
hset 在散列里面关联起给定的键值对 1(新增)/0(更新) hset('hash-key', 'sub-key', 'value') (不支持数组、字符串)
hget 获取指定散列键的值 hget('hash-key', 'sub-key')
hgetall 获取散列包含的键值对 json hgetall('hash-key')
hdel 如果给定键存在于散列里面，则移除这个键 hdel('hash-key', 'sub-key')
hmset 为散列里面的一个或多个键设置值 OK hmset('hash-key', obj)
hmget 从散列里面获取一个或多个键的值 array hmget('hash-key', array)
hlen 返回散列包含的键值对数量 hlen('hash-key')
hexists 检查给定键是否在散列中 1/0 hexists('hash-key', 'sub-key')
hkeys 获取散列包含的所有键 array hkeys('hash-key')
hvals 获取散列包含的所有值 array hvals('hash-key')
hincrby 将存储的键值以指定增量增加 返回增长后的值 hincrby('hash-key', 'sub-key', increment) (注：假如当前value不为为字符串，则会无输出，程序停止在此处)
hincrbyfloat 将存储的键值以指定浮点数增加

//zset
命令 行为 返回值 使用示例(略去回调函数)
zadd 将一个带有给定分支的成员添加到有序集合中 zadd('zset-key', score, 'key') (score为int)
zrange 根据元素在有序排列中的位置，从中取出元素
zrangebyscore 获取有序集合在给定分值范围内的所有元素
zrem 如果给定成员存在于有序集合，则移除
zcard 获取一个有序集合中的成员数量 有序集的元素个数 zcard('key')


keys命令组
命令 行为 返回值 使用示例(略去回调函数)
del 删除一个(或多个)keys 被删除的keys的数量 del('key1'[, 'key2', ...])
exists 查询一个key是否存在 1/0 exists('key')
expire 设置一个key的过期的秒数 1/0 expire('key', seconds)
pexpire 设置一个key的过期的毫秒数 1/0 pexpire('key', milliseconds)
expireat 设置一个UNIX时间戳的过期时间 1/0 expireat('key', timestamp)
pexpireat 设置一个UNIX时间戳的过期时间(毫秒) 1/0 pexpireat('key', milliseconds-timestamp)
persist 移除key的过期时间 1/0 persist('key')
sort 对队列、集合、有序集合排序 排序完成的队列等 sort('key'[, pattern, limit offset count])
flushdb 清空当前数据库


# pom 操作文档 
https://www.cnblogs.com/bf-blackfish/p/10907347.html




# 新版编辑器  muya




# 导出mysql 需要先执行 文章地址替换
```mysql
 update test set mark_content=replace(mark_content,'http://www.a.com','https://www.gitce.top')
```