/*
 * @Author: Chen
 * @Email: cnblogco@qq.com
 * @Date: 2020-10-21 13:47:00
 * @LastEditTime: 2022-04-09 23:21:11
 * @Description: ...每位新修改者自己的信息
 */
const config = require('@/config')
const requestIp = require('request-ip');
const { v4: uuidv4 } = require('uuid');
const UAParser = require("ua-parser-js");


const toLiteral = (str) => {
  var dict = { '\b': 'b', '\t': 't', '\n': 'n', '\v': 'v', '\f': 'f', '\r': 'r' };
  return str.replace(/([\\'"\b\t\n\v\f\r])/g, function ($0, $1) {
    return '\\' + (dict[$1] || $1);
  });
}




// 获取文章中的图片id
const getMarkImageName = (content) => {
  let image = /(!\[((?:\[[^\]]*\]|[^\[\]])*)\]\()(<?((?:\([^)]*\)|[^()])*?)>?[ \t]*((['"])((?:.|\n)*?)\6[ \t]*)?)(\)(?:\s*{([^{}\(\)]*)})?)/ig

  let rows = []

  let getImageName = (link) => {
    let rx = /(^\![\[\u3010]((?:[\[\u3010][^\]\u3011]*[\]\u3011]|[^\[\]\u3010\u3011])*)[\]\u3011][\(\uff08])((.|\n)*)([\)\uff09](?:\s*{([^{}\(\)\uff08\uff09]*)})?)/
    let [, , , url] = link.match(rx)
    if (!url) return ''
    let linkArr = link.split('/')
    let [name] = linkArr[linkArr.length - 1].split('.')
    return name
  }

  let linkAll = content.match(image)
  for (let i in linkAll) {
    let name = linkAll[i]
    if (name.includes(config.replaceRows.host)) rows.push(getImageName(name))
  }

  return rows

}


/**
 *  获取用户IP地址
 * @param {*} req 
 * @returns 
 */
const ip = (req) => {
  let ips = req.clientIp
  let address = ips.indexOf(':') !== -1 ? ips.split(':') : ips;
  let ipAddress = address
  if (ips.indexOf(':') !== -1) ipAddress = address[3];
  return ipAddress
}

/**
 * 内外网ip判断
 * @param {*} address 
 * @returns 
 */
const checkIsInsideIP = function (ipAddress) {
  if (ipAddress == "127.0.0.1" || ipAddress == "localhost") {
    return true;
  }
  var aryIpAddress = ipAddress.split('.');
  if (aryIpAddress[0] == "10") {
    return true;
  }
  if (aryIpAddress[0] == "192" && aryIpAddress[1] == "168") {
    return true;
  }
  if (aryIpAddress[0] == "172") {
    var num = parseInt(aryIpAddress[1]);
    if (num >= 16 && num <= 31) {
      return true;
    }
  }

  return false;
}



/**
 * 生成UUid
 * @returns 
 */
const uuid = () => {
  return uuidv4()
}



/**
 * 统计用户登录
 * @param {*} str 
 * @returns 
 */
const getUserAgent = (req) => {
  let str = req.headers['user-agent']
  var uaParser = new UAParser(str);
  let user = uaParser.getResult()
  let { os, browser, ua } = user
  return {
    os: os.name ? (os.name + os.version) : "",
    browser: browser.name ? (browser.name + browser.version) : ua
  }
}




/**
 *  部门递归遍历
 * @param {*} id 
 * @param {*} data 
 * @returns 
 */
let treeDept = (id, data = [], key = {}) => {
  if (data.length === 0) return []
  let arrays = []
  for (let i in data) {
    let item = data[i]
    if (item.parentId === id) {
      let row = {
        id: item[key.id],
        label: item[key.label],
      }
      row.children = treeDept(row.id, data, key)
      if (row.children.length === 0) delete row.children
      arrays.push(row)
    }
  }
  return arrays
}




function ishttp (url) {
  var reg = /http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
  return reg.test(url)
}





module.exports = {
  toLiteral, ip, uuid, getUserAgent, checkIsInsideIP, treeDept, ishttp, getMarkImageName
}