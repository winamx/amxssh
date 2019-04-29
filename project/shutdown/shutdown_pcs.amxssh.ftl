<#setting locale="zh_CN"/>

<#-- 引用json文件  json_pcs -->
<#assign json_pcs><#include "shutdown_pcs.json" /></#assign>

<#--转换成值  赋给变量pcs 后面使用 pcs引用 -->
<#assign pcs=json_pcs?eval />

<#list pcs as pc>

	<#assign args_shell_pc="os=\"${pc.os}\", ip=\"${pc.ip}\", port=${pc.port}, uid=\"${pc.uid}\", pwd=\"${pc.pwd}\"" />
	
	//windows关机操作 ${pc.ip}	
	amxssh-shell(${args_shell_pc}){		
		
		echo "::amxssh::开始执行关机指令 - ${pc.os} ${pc.ip}"
		
		<#if "${pc.os}" == "windows" >			
		shutdown -t 0 -f -s			
		<#else>			
		halt -p			
		</#if>
				
		echo "::amxssh::exit"	
	} 
		
</#list>