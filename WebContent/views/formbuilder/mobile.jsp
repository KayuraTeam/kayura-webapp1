<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>手机表单设计器</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="description" content="">
<link rel="stylesheet" href="${ROOT}/res/formbuilder/vendor/css/vendor.css" />
<link rel="stylesheet" href="${ROOT}/res/formbuilder/formbuilder.css" />
<style>
* {
	box-sizing: border-box;
}

body {
	background-color: #444;
	font-family: sans-serif;
}

input[type=text] {
	height: 32px;
	margin-bottom: 3px;
}

select {
	margin-bottom: 5px;
	font-size: 32px;
}
</style>
</head>
<body>
	<div class='fb-main' style="margin-top:50px"></div>

	<script src="${ROOT}/res/formbuilder/vendor/js/vendor.js"></script>
	<script src="${ROOT}/res/formbuilder/formbuilder.js"></script>

	<script>
		$(function() {
			var fb = new Formbuilder({
				selector : '.fb-main',
				bootstrapData : [{"label":"妮称","field_type":"text","required":false,"field_options":{"minlength":"10","maxlength":"200","length_units":"words"},"cid":"c17","name":"nick","description":"请输入您的妮称","placeholder":"此输入"},{"label":"清单明细项","field_type":"table-begin","required":false,"field_options":{},"cid":"c9","description":"清单明细项"},{"label":"物品名称","field_type":"text","required":false,"field_options":{},"cid":"c22","name":"wpm","placeholder":"此处输入物品名"},{"label":"物品数量","field_type":"number","required":false,"field_options":{"units":"件","min":"0","max":"100"},"cid":"c49","name":"wpl"},{"label":"","field_type":"table-end","required":false,"field_options":{"action_name":"添加新项"},"cid":"c5"},{"label":"备注","field_type":"textarea","required":false,"field_options":{"minlength":"0","maxlength":"512","length_units":"words"},"cid":"c30","name":"remark","description":"有些其它要说的吗","placeholder":"输入备注信息"}]
			});

			fb.on('save', function(payload) {
				console.log(payload);
			});
		});
	</script>

</body>
</html>