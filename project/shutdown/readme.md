# [��Ŀ](../../readme.md "amxssh")��shutdown

## ����

�칫�Ҳ��Ի������м�ʮ̨����������������������������Ҫ����ϵͳ��

1)windows server 2008/2012 

2)linux centos6.5

ÿ�����Ľڼ��ջ��߽ӵ���ҵ����ͣ��֪ͨ����Ҫ�ر�ָ���б�ķ�������

## ʹ��

�޸�json�����ļ�`shutdown_pcs.json`

```json
[
	{
		"os": "windows",
		"ip": "192.168.1.51",
		"port": "8022",
		"uid": "administrator",
		"pwd": "����"
	},
	{
		"os": "windows",
		"ip": "192.168.1.59",
		"port": "8022",
		"uid": "administrator",
		"pwd": "����"
	},
	{
		"os": "linux",
		"ip": "192.168.1.174",
		"port": "22",
		"uid": "root",
		"pwd": "����"
	}
]

```