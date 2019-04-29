# [项目](https://github.com/winamx/amxssh "amxssh")：svnbackup

## 背景

SVN有完整备份和增量备份两种情况：

一、完整备份通常阶段性执行一次。

1.1 可能有人提交代码的情况。svnadmin hotcopy
mkdir C:\nexus-server.svn\svn_dump\WorkSpace-NP
svnadmin hotcopy e:\Repositories\WorkSpace-NP C:\nexus-server.svn\svn_dump\WorkSpace-NP

1.2 没人提交代码的情况。xcopy
mkdir C:\nexus-server.svn\svn_dump\WorkSpace-NP
xcopy /e /h e:\Repositories\WorkSpace-NP C:\nexus-server.svn\svn_dump\WorkSpace-NP


二、增量备份为了保证版本同步经常执行。

2.1 查询备份库的版本
```bat
cd /d C:\nexus-server.svn\Repositories\WorkSpace-NP
svnlook youngest .
21156
```

2.2 查询服务库的版本
```bat
cd /d E:\Repositories\WorkSpace-NP
svnlook youngest .
21164
```
2.3 产生备份文件
```
svnadmin dump . -r 21157:21164 --incremental  > x:\svnrootbak\WorkSpace-NP21157-21164
```

2.4 下载备份文件 执行增量导入
```
svnadmin load . < C:\nexus-server.svn\dump\WorkSpace-NP21157-21164
```
 

## 使用

修改json配置文件`svn_backup.json`

```json
{
	"src": {
		"os": "windows",
		"ip": "192.168.1.253",
		"port": "8022",
		"uid": "administrator",
		"pwd": "密码",
		"dir_root": "e:/Repositories/",
		"svn_home": "c:/Program Files/TortoiseSVN/",
		"dir_dump": "d:/svn_dump/"
	},
	"dest": {
		"os": "windows",
		"ip": "192.168.6.11",
		"port": "8022",
		"uid": "administrator",
		"pwd": "密码",
		"dir_root": "c:/nexus-server.svn/Repositories/",
		"svn_home": "g:/Program Files/TortoiseSVN/",
		"dir_dump": "c:/nexus-server.svn/svn_dump/"
	},
	"dbs": [		
		"WorkSpace-BASE",
		"WorkSpace-FACE",
		"WorkSpace-E",
		"WorkSpace-IoD",
		"WorkSpace-A",
		"WorkSpace-B",
		"WorkSpace-NP",
		"Workspace-C",
		"WorkSpace-D",
		"WorkX"
	]
}

```
