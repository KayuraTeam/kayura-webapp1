<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<k:section name="title">表单定义</k:section>

<k:section name="head">
	<script type="text/javascript">
	
		$(function(){ 
			jctx.init(); 
		});
		
		var jctx = (function($, win){
			
			function _init() {
				
				$('#tg').datagrid({
					url: "${root}/bpm/biz/find.json",
					queryParams: {
						keyword : $('#search').val()
					}
				});
			}
			
			function _search(){
				
				$('#tg').datagrid('load', {
					keyword : $('#search').val()
				});
			}
			
			function _create(){
				juasp.openWin({
					url: "${root}/bpm/biz/new",
					width: "450px",
					height: "500px",
					title: "创建表单项",
					onClose : function(result){
						if(result == 1){
							_search();
						}
					}
				});
			}
			
			function _edit(){
				
				var row = $('#tg').datagrid("getSelected");
				if(row != null){
					
					juasp.openWin({
						url: "${root}/bpm/biz/edit?id=" + row.id,
						width: "450px",
						height: "500px",
						title: "编辑表单",
						maximized: true,
						onClose : function(result){
							if(result == 1){
								_search();
							}
						}
					});
				}
			}
			
			function _remove(){
				
				var rows = $('#tg').datagrid("getSelections");
				if(rows != null){
					
					var ids = [], names = [];
					$.each(rows, function(index, item) {
						ids.push(item.id);
						names.push(item.displayName);
					});

					juasp.confirm("<b>是否确认删除表单定义</b> 【" + names.join(", ") + "】<b> " + ids.length + " 个文件。</b>", 
						function(r) {
							if (r == true) {
								juasp.post('${root}/bpm/biz/remove.json', 
										{ ids : ids.join(",") },
										{ success : function(r) { _search(); } }
								);
							}
					});
				}
			}
						
			return {
				init: _init,
				create: _create,
				edit: _edit,
				remove: _remove,
				search: _search,
			};
			
		}(jQuery, window));
		
	</script>
</k:section>

<k:section name="body">
	<k:datagrid id="tg" fit="true" rownumbers="true"
		pagination="true" pageSize="10" singleSelect="true" striped="true"
		toolbar="#tb" idField="id">
		<k:column field="ck" checkbox="true" />
		<k:column field="code" title="编码" />
		<k:column field="displayName" title="显示名" />
		<k:column field="processKey" title="流程键" />
		<k:column field="typeName" title="类型" />
		<k:column field="statusName" title="状态" />
	</k:datagrid>
	<div id="tb">
		<k:linkbutton id="newBiz" iconCls="icon-add" plain="true" text="创建表单" onClick="jctx.create()" />
		<k:linkbutton id="editBiz" iconCls="icon-add" plain="true" text="编辑表单" onClick="jctx.edit()" />
		<k:linkbutton id="removeBiz" iconCls="icon-add" plain="true" text="删除表单" onClick="jctx.remove()" />
		<div style="float: right;">
			<k:searchbox id="search" prompt="搜索：编号、显示名、描述" width="220" height="25" searcher="jctx.search" />
		</div>
	</div>
</k:section>

<%@ include file="/shared/_list.jsp"%>