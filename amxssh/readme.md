# [amxssh](https://github.com/winamx/amxssh "amxssh")

项目AmxSSH定义了一个轻量级的远程操作脚本语言，提供了一种脚本操作远程的途径。

基于SSH,SFTP,FTL,JSON等相关技术，可以巧妙的操作windows、Linux系统，进而减少重复劳动。

语言初步定义了以下操作：

```java
//一、注释 内容，目前只支持以"//"开始的行注释，不支持在行尾注释

//建议使用以 "/" 开头的绝对路径，如果使用相对路径 则以脚本文件为相对路径
	

//二、模板解析 包含模板需要的参数名字数量不限
amxssh-ftl(app_ip="192.168.1.162", basedir="/home/BD/V3.0/mysql/mysql-5.5.41", datadir="/home/BD/V3.0/mysql/mysql-5.5.41/data"){
	//处理单个文件		
	//ftl_file("ftl/app_install.ftl", "/E:/BD/V3.0/temp/192.168.1.162/TBDAS/app_install.amxssh", true);

	//处理目录
	//1.普通文件直接拷贝到新目录 2.所有以ftl结尾的文件会模板处理，并将文件名后缀.ftl移除 保存到目标目录
	//ftl_dir("E:\BD\V3.0\BD_V3.0Buid001Patch001Date20190221\config\linux\mysql-5.5.41\support-files", "*.ftl", "/E:/BD/V3.0/temp/192.168.1.162/TBDAS/", true);			
}
	

//三、在目标机器上执行指令 至少包含 os ip port uid pwd参数
amxssh-shell(os="linux", ip="192.168.1.162", port="22", uid="root", pwd="123456"){		
	//echo "::amxssh::测试shell消息，带特殊含义的控制消息"		
	//echo "普通消息"		
	//echo "::amxssh::exit"	
}

//四、文件木 上传下载 删除 至少包含 os ip port uid pwd参数
amxssh-sftp(os="linux", ip="192.168.1.162", port="22", uid="root", pwd="123456"){
	
	//文件上传(本地源文件, 远程目标文件, 递归true)
	//sftp_upload("/E:/BD/V3.0/TBD_V3.0Buid001Patch001Date20190221/package/linux/snmp/","/home/BD_installPackage/package/snmp/", true);
	
	//文件下载(远程源文件, 本地文件，递归true)
	//sftp_download("/home/BD_installPackage/package/snmp/", "/E:/BD/V3.0/TBD_V3.0Buid001Patch001Date20190221/package/linux/snmp_backup/", true);
	
	//文件删除(文件/目录, 递归true)		
	//sftp_rm("/home/BD_installPackage/package/snmp/", true);
}


//五、文件:保存文件(文件名, 写或者追加 write/append, 字符编码)
amxssh-file(name="/E:/BD/V3.0/temp/192.168.1.162/TBDAS/setupinfo.json", io="write", charset="utf-8"){
	//中间不能有 "amxssh-" 否则会破坏结构
	//注释将被过滤 剩下的内容将被保存未文件
	//{
	//	"tt":"this is 文本内容",
	//	"node":{"ip":"192.168.1.174", "port": 22}
	//}
	
}

//六、调用其他脚本
amxssh-call(){
	//调用脚本
	//call_file("D:\Workspace-SETUP\project\UpdateSSH\svn\svn_backup.amxssh");	
		
	//以行为单位去重
	//distinct_file("D:\Workspace-SETUP\project\InstallServer\src\main\resources\all\authorized_keys", "utf-8");

	//拷贝文件 源文件/目录，目标目录
	//cp_file("svn_backup_item.ftl", "bin");
	
	//删除文件或者目录	
	//rm_file("/E:/BD/V3.0/temp/192.168.1.162/TBDAS/setupinfo.json");
	//rm_file("/E:/BD/V3.0/temp");	
}	
	

```	
