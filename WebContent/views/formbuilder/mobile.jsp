<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Form Builder</title>
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
				bootstrapData : [ {
					"label" : "请输入您的电话号码",
					"field_type" : "text",
					"required" : true,
					"field_options" : {
						"size" : "large"
					},
					"name" : "myphone",
					"cid" : "c6"
				}, {
					"label" : "是否为管理员?",
					"field_type" : "radio",
					"required" : true,
					"field_options" : {
						"options" : [ {
							"label" : "是",
							"checked" : false
						}, {
							"label" : "否",
							"checked" : false
						} ],
						"include_other_option" : true
					},
					"cid" : "c10"
				}]
			});

			fb.on('save', function(payload) {
				console.log(payload);
			});
		});
	</script>

</body>
</html>