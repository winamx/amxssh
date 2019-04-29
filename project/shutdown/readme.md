# [项目](https://github.com/winamx/amxssh "amxssh")：shutdown

## 背景

办公室测试环境，有几十台服务器（有物理机、虚拟机），主要两类系统：

1)windows server 2008/2012 

2)linux centos6.5

每当长的节假日或者接到物业管理处停电通知，需要关闭指定列表的服务器。

## 使用

修改json配置文件`shutdown_pcs.json`

```json
[
	{
		"os": "windows",
		"ip": "192.168.1.51",
		"port": "8022",
		"uid": "administrator",
		"pwd": "密码"
	},
	{
		"os": "windows",
		"ip": "192.168.1.59",
		"port": "8022",
		"uid": "administrator",
		"pwd": "密码"
	},
	{
		"os": "linux",
		"ip": "192.168.1.174",
		"port": "22",
		"uid": "root",
		"pwd": "密码"
	}
]

```
