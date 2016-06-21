<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<k:datagrid id="tg" fit="true" rownumbers="true" border="false" 
	pagination="true" pageSize="10" singleSelect="true" striped="true"
	toolbar="#tb" idField="id" url="${root}/bpm/task/find.json">
	<k:column field="name" title="任务名称" />
	<k:column field="processInstanceId" title="过程实例Id" />
	<k:column field="processDefinitionId" title="过程定义Id" />
	<k:column field="createTime" title="创建时间" />
	<k:column field="assignee" title="处理人" />
	<k:column field="id" width="80" title="操作项" align="center" formatter="jtasklist.formaterActions"/>
</k:datagrid>
<div id="tb">
	<k:linkbutton id="deploy" iconCls="icon-add" plain="true" text="上传流程" onClick="" />
	<div style="float: right;">
		<k:searchbox id="search" prompt="搜索：任务名称" width="220" height="25" searcher="jtasklist.search" />
	</div>
</div>
<script type="text/javascript">

	var jtasklist = (function($, win){

		function _init(){
			
/* 			$('#tg').datagrid({
				url: "${root}/bpm/task/find.json",
				queryParams: {
					keyword : $('#search').val()
				}
			}); */
		}
		
		function _search(){
			$('#tg').datagrid('load', {
				keyword : $('#search').val()
			});
		}
		
		function _taskclaim(id){
			
			juasp.post("${root}/bpm/task/claim.json", { "id": id },
			{
				success: function(r){
					juasp.infoTips("任务签收完成.");
					_search();
				}
			});
		}
		
		function _taskread(id){
			
			juasp.openWin({
				url: "${root}/bpm/task/read?id=" + id,
				width: "550px",
				height: "600px",
				title: "处理任务",
				onClose : function(result){
					if(result == 1){
						_search();
					}
				}
			});
		}
		
		function _formaterActions(value, row, index){
			
 			if(juasp.isEmpty(row.assignee)){
				return "<a href='###' onclick=\"jtasklist.taskclaim('"+ row.id + "')\" >签收</a>";
			} else {
				return "<a href='###' onclick=\"jtasklist.taskread('"+ row.id + "')\" >处理</a>";
			}
		}
		
		return {
			init: _init,
			search: _search,
			taskclaim: _taskclaim,
			taskread: _taskread,
			formaterActions: _formaterActions
		};
		
	}(jQuery, window));

	$(function(){
		jtasklist.init();
	});
	
</script>