/*
 * @Author: Chen
 * @Email: codeeetop@qq.com
 * @Date: 2022-03-17 09:23:30
 * @LastEditTime: 2022-03-17 09:59:43
 * @Description: ...每位新修改者自己的信息
 */
import JSEncrypt from 'jsencrypt/bin/jsencrypt.min'

// 密钥对生成 http://web.chacuo.net/netrsakeypair

const publicKey = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDxcxszReNh21ngeKu6yPdImfxl00dzmF420IbaI6Gv6//5PSWk0EOIZYbyFoW/t85MxSBrybB1YUDyyXXipmHAYdmjKqDSfGYIfIkFA8Gr05DRCRe32WSjN/ntH0KAm9ruv7Xafgn20x+GOtn5sECuKyjwp27dN6DjIuD4aOfpKwIDAQAB'
const privateKey = ''

// 加密
export function encrypt(txt) {
  const encryptor = new JSEncrypt()
  encryptor.setPublicKey(publicKey) // 设置公钥
  return encryptor.encrypt(txt) // 对数据进行加密
}

// 解密
export function decrypt(txt) {
  const encryptor = new JSEncrypt()
  encryptor.setPrivateKey(privateKey) // 设置私钥
  return encryptor.decrypt(txt) // 对数据进行解密
}

