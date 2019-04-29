
<#setting locale="zh_CN"/>

<#assign json_src><#include "svn.src.info.json" /></#assign>
<#assign src=json_src?eval />

<#assign json_dest><#include "svn.dest.info.json" /></#assign>
<#assign dest=json_dest?eval /> 

<#assign args_shell_src="os=\"${src.os}\", ip=\"${src.ip}\", port=${src.port}, uid=\"${src.uid}\", pwd=\"${src.pwd}\""
		args_sftp_src = args_shell_src
		
		args_shell_dest="os=\"${dest.os}\", ip=\"${dest.ip}\", port=${dest.port}, uid=\"${dest.uid}\", pwd=\"${dest.pwd}\""
		args_sftp_dest = args_shell_dest
	/>


<#noparse>
<#setting locale="zh_CN"/>
	
<#assign json_dest><#include </#noparse>"${db}_dest.json" <#noparse> /></#assign>	
<#assign config_dest=json_dest?eval />

<#assign json_src><#include </#noparse>"${db}_src.json" <#noparse> /> </#assign>	
<#assign config_src=json_src?eval /> </#noparse>
	
<#noparse><#if config_dest.ver_cur == config_src.ver_cur ></#noparse>

	amxssh-shell(${args_shell_dest}){
		@echo off	
		echo "::amxssh::无需备份:${db}" 
		echo "::amxssh::exit"
	}
	

<#noparse> <#else>
	<#assign v1=config_dest.ver_cur+1 v2=config_src.ver_cur 
			svn_ver_f="${v1?c}-${v2?c}"
			svn_ver_p="${v1?c}:${v2?c}"
		/>
 </#noparse>


	//2.1 产生备份文件
	//svnadmin dump . -r 21157:21164 --incremental  > x:/svnrootbak/db21157-21164		
	
	amxssh-shell(${args_shell_src}){	
		//@echo off
		echo "::amxssh::开始备份:${db}"
		//生成dump目录
		if not exist ${src.dir_dump} mkdir ${src.dir_dump}
				
		"${src.svn_home}bin/svnadmin.exe" dump ${src.dir_root}${db} -r <#noparse>${svn_ver_p}</#noparse> --incremental > ${src.dir_dump}${db}<#noparse>-${svn_ver_f}</#noparse>		
		 
		echo "::amxssh::exit"
	}
	
	//2.2 下载文件
	amxssh-sftp(${args_sftp_src}){		 
		sftp_download("${src.dir_dump}${db}<#noparse>-${svn_ver_f}</#noparse>", "", true);
		sftp_rm("${src.dir_dump}${db}<#noparse>-${svn_ver_f}</#noparse>", true);
	}
	
	
	//2.3 上传文件
	amxssh-sftp(${args_sftp_dest}){		 
		sftp_upload("${db}<#noparse>-${svn_ver_f}</#noparse>", "${dest.dir_dump}", true);
	}

	//2.4 执行增量导入
	//svnadmin load . < C:/nexus-server.svn/dump/dumpfile21157-21164
	amxssh-shell(${args_shell_dest}){
		//@echo off
		"${dest.svn_home}bin/svnadmin.exe" load ${dest.dir_root}${db} < ${dest.dir_dump}${db}<#noparse>-${svn_ver_f}</#noparse>
		del /f /q ${dest.dir_dump?replace("/","\\")}${db}<#noparse>-${svn_ver_f}</#noparse>
		
		echo "::amxssh::exit"
	}

<#noparse> </#if> </#noparse>
	

  