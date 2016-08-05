<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${model.title}</title>
</head>
<body>
	<form action="">
		<input type="hidden" id="dataId" name="dataId" value="${mode.dataId}">
		<input type="hidden" id="modelId" name="modelId" value="${mode.modelId}">
		<h2>${model.title}</h2>
		<h3>${model.description}</h3>
		<table>
			<c:forEach var="field" items="${model.fields}">
				<c:set var="m" value="${field.model}" />
				<c:if test="${m.fieldType == 'Text'}">
					<tr>
						<td>${m.lable}</td>
						<td><input type="text" id="${m.id}" name="${m.name}" value="${field.value}">
						</td>
					</tr>
				</c:if>
				<c:if test="${m.fieldType == 'TextArea'}">
					<tr>
						<td>${m.lable}</td>
						<td><textarea id="${m.id}" name="${m.name}" rows="5" cols="50">${field.value}</textarea>
						</td>
					</tr>
				</c:if>
				<c:if test="${m.fieldType == 'Date'}">
					<tr>
						<td>${m.lable}</td>
						<td><input type="date" id="${m.id}" name="${m.name}" value="${field.value}">
						</td>
					</tr>
				</c:if>
				<c:if test="${m.fieldType == 'Number'}">
					<tr>
						<td>${m.lable}</td>
						<td><input type="number" id="${m.id}" name="${m.name}" value="${field.value}">
						</td>
					</tr>
				</c:if>
				<c:if test="${m.fieldType == 'Select'}">
					<tr>
						<td>${m.lable}</td>
						<td>
							<select type="text" id="${m.id}" name="${m.name}" value="${field.value}">
								<c:forEach var="o" items="${m.options}">
									<option label="${o.label}" <c:if test="${o.checked}">selected</c:if> >${o.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<tr>
				<td>创建时间</td>
				<td>${model.createTime}</td>
			</tr>
			<tr>
				<td>创建人</td>
				<td>${model.creator}</td>
			</tr>
			<tr>
				<td>更新时间</td>
				<td>${model.updateTime}</td>
			</tr>
		</table>
	</form>
</body>
</html>