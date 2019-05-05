<#setting locale="zh_CN"/>

<#assign json_config>
<#include "svn_backup.json" />
</#assign>

<#assign config=json_config?eval />

<#assign src=config.src dest=config.dest dbs=config.dbs >
 

<#assign args_shell_src="os=\"${src.os}\", ip=\"${src.ip}\", port=${src.port}, uid=\"${src.uid}\", pwd=\"${src.pwd}\""
		args_sftp_src = args_shell_src
		
		args_shell_dest="os=\"${dest.os}\", ip=\"${dest.ip}\", port=${dest.port}, uid=\"${dest.uid}\", pwd=\"${dest.pwd}\""
		args_sftp_dest = args_shell_dest
						 
	/>


<#function fun_object2Json object>
    <#if object?? >
        <#if object?is_enumerable>
            <#local json = "[" />
            <#list object as item>   
                <#if item_index &gt; 0 && json != "[" >
                    <#local json = json +',' />
                </#if>
                <#local json = json + fun_object2Json(item) />
            </#list>
            <#return json + ']' />
        <#elseif object?is_hash>            
			<#local json = "{" />
            <#assign keys = object?keys />
            <#list keys as key>
                <#if object[key]?? && !(object[key]?is_method) && key != "class">
					<#if key_index &gt; 0 && json != "{" >
	                    <#local json = json +',' />
	                </#if>
					<#local json = json + '"${key}":' +  fun_object2Json(object[key]) />
                </#if>
            </#list>
            <#return json +"}" />
		<#elseif object?is_number>		
			<#local json =  "${object?c}" />
			<#return json />			
		<#elseif object?is_string>		
			<#local json = '"${object}"' />
			<#return json />			
		<#elseif object?is_boolean >		
			<#local json = '${object?string("true", "false")}' />
			<#return json />					
		</#if>
    <#else>
        <#return "{}" />
    </#if>
</#function>


amxssh-file(name="svn.src.info.json", io="write", charset="utf-8"){
	${fun_object2Json(src)}
}
amxssh-file(name="svn.dest.info.json", io="write", charset="utf-8"){
	${fun_object2Json(dest)} 
}	
	

<#list dbs as db>
	 
	 <#assign proj_name_dest="${dest.dir_dump}${db}_dest.json" proj_name_src="${src.dir_dump}${db}_src.json" >
	
	//svn更新:${db}
	//1.获取备份版本
	amxssh-shell(${args_shell_dest}){	
		//@echo off
		if not exist ${dest.dir_dump} mkdir ${dest.dir_dump?replace("/","\\")}
		for /F %%i in ('"${dest.svn_home}bin/svnlook.exe" youngest ${dest.dir_root}${db}') do ( set VER_CUR=%%i)		
		echo { "proj_name": "${db}", "ver_cur":%VER_CUR% } >${proj_name_dest}		
		echo "::amxssh::exit"	
	}
	
	//2.下载备份版本信息	
	amxssh-sftp(${args_sftp_dest}){		 
		sftp_download("${proj_name_dest}", "", true);
		sftp_rm("${proj_name_dest}");			
	}
	
	//3.获取源版本
	amxssh-shell(${args_shell_src}){	
		//@echo off
		if not exist ${src.dir_dump} mkdir ${src.dir_dump?replace("/","\\")}
		for /F %%i in ('"${src.svn_home}bin/svnlook.exe" youngest ${src.dir_root}${db}') do ( set VER_CUR=%%i)		
		echo { "proj_name": "${db}", "ver_cur":%VER_CUR% } >${proj_name_src}		
		echo "::amxssh::exit"	
	}
	
	//4.下载备份版本信息	
	amxssh-sftp(${args_sftp_src}){		 
		sftp_download("${proj_name_src}", "", true);
		sftp_rm("${proj_name_src}");	
	}

	//5.产生备份ftl
	amxssh-ftl(db="${db}"){
		ftl_file("svn_backup_item.ftl", "${db}_svn_backup.ftl");		
		ftl_file("${db}_svn_backup.ftl", "${db}_svn_backup.amxssh");	
	}
	
	//6.执行备份
	amxssh-call(){	 
		call_file("${db}_svn_backup.amxssh");
		
		rm_file("${db}_svn_backup.ftl");
		rm_file("${db}_svn_backup.amxssh");
		
	}

</#list>