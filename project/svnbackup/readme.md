# [��Ŀ](../../readme.md "amxssh")��svnbackup

##����

SVN���������ݺ������������������

һ����������ͨ���׶���ִ��һ�Ρ�

1.1 ���������ύ����������svnadmin hotcopy
mkdir C:\nexus-server.svn\svn_dump\WorkSpace-NP
svnadmin hotcopy e:\Repositories\WorkSpace-NP C:\nexus-server.svn\svn_dump\WorkSpace-NP

1.2 û���ύ����������xcopy
mkdir C:\nexus-server.svn\svn_dump\WorkSpace-NP
xcopy /e /h e:\Repositories\WorkSpace-NP C:\nexus-server.svn\svn_dump\WorkSpace-NP


������������Ϊ�˱�֤�汾ͬ������ִ�С�

2.1 ��ѯ���ݿ�İ汾
```bat
cd /d C:\nexus-server.svn\Repositories\WorkSpace-NP
svnlook youngest .
21156
```

2.2 ��ѯ�����İ汾
```bat
cd /d E:\Repositories\WorkSpace-NP
svnlook youngest .
21164
```
2.3 ���������ļ�
```
svnadmin dump . -r 21157:21164 --incremental  > x:\svnrootbak\WorkSpace-NP21157-21164
```

2.4 ���ر����ļ� ִ����������
```
svnadmin load . < C:\nexus-server.svn\dump\WorkSpace-NP21157-21164
```
 

##ʹ��

�޸�json�����ļ�`svn_backup.json`

```json
{
	"src": {
		"os": "windows",
		"ip": "192.168.1.253",
		"port": "8022",
		"uid": "administrator",
		"pwd": "����",
		"dir_root": "e:/Repositories/",
		"svn_home": "c:/Program Files/TortoiseSVN/",
		"dir_dump": "d:/svn_dump/"
	},
	"dest": {
		"os": "windows",
		"ip": "192.168.6.11",
		"port": "8022",
		"uid": "administrator",
		"pwd": "����",
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