<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglibs/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
  <title>论著列表</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="${ctx}/css/messenger.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/css/messenger-theme-flat.css" type="text/css" />
  <script type="text/javascript" src="${ctx}/js/messenger.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/messenger-theme-flat.js"></script>
  <script type="text/javascript" src="${ctx}/js/util.js"></script>
  <script type="text/javascript">
  	$(function(){
  		if('${message}' != ""){
  			Messenger.options = {
			    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
			    theme: 'flat'
			}
		 	Messenger().post({
			  message: "<h5>${message}</h5>",
		 	  hideAfter: 3,
		 	  showCloseButton: true,
		 	});
  		} 
  		$("[data-toggle='tooltip']").tooltip();
  	 });
  	
  	function toUpdate( id ){
		window.location.href="${ctx}/bookAction/toUpdate/"+id;  		
  	}
  	
  	function doDel( type, id ){
  		window.location.href = "${ctx}/bookAction/doDelete/"+type+"/"+id;
  	}
  	
  	function details( id ){
  		window.location.href = "${ctx}/bookAction/details/"+id;
  	}
  </script>
</head>
<body onload="displayPart('${fn:length(newsList)}');">
  <c:import url="../top.jsp" />
  <div class="container"> 
    <div class="template-page-wrapper">
 	<c:import url="../menu.jsp" />
     <div class="templatemo-content-wrapper">
        <div class="templatemo-content">
          <ol class="breadcrumb">
            <li><span class="glyphicon glyphicon-home"></span>&nbsp;<a href="${ctx }/loginAction/main">主页</a></li>
            <li class="active">论著列表</li>
          </ol>
          <blockquote>
				<span class="glyphicon glyphicon-th-list"></span>&nbsp;论著列表&nbsp;<span class="caret"></span>
		  </blockquote>
		  <form:form action="${ctx }/bookAction/toList_page?type=${type }" id="pageForm" method="POST">
          <div class="table-responsive" style="margin: -25px 0 0 0;">
          <!-- Split button -->
          <c:if test="${user.role == 'teacher' }">
			<div class="btn-group pull-right" style="margin-bottom: 5px">
			  <button type="button" class="btn btn-success btn-sm" onclick="javascript:window.location.href='${ctx }/bookAction/toAdd?type=${type }'">添加</button>
			  <button type="button" class="btn btn-success dropdown-toggle" style="height: 30px" data-toggle="dropdown" aria-expanded="false">
			    <span class="caret"></span>
			    <span class="sr-only">Toggle Dropdown</span>
			  </button>
			  <ul class="dropdown-menu" role="menu">
			    <li><a href="${ctx }/bookAction/toList_page?orderBy=ASC&type=${type }">创建时间升序</a></li>
			    <li><a href="${ctx }/bookAction/toList_page?orderBy=DESC&type=${type }">创建时间降序</a></li>
			    <li class="divider"></li>
			    <li><a href="${ctx }/bookAction/toList_page?type=${type }">刷新列表</a></li>
			  </ul>
			</div>
		  </c:if>
		  <table class="table table-striped table-hover table-bordered">
		  	<tr>
		  		<td>#</td>
		  		<td>论著名称</td>
			  	<c:if test="${user.role == 'manager' }">
		  			<td>所属教师</td>
		  		</c:if>
		  		<td>论著类别</td>
		  		<td>出版时间</td>
		  		<td>论著字数</td>
		  		<td>是否主编</td>
		  		<td>创建时间</td>
		  		<td>
		  			操作
		  		</td>
		  	</tr>	 
		  	<c:choose>
		  		<c:when test="${bookList== null || fn:length(bookList) == 0}">
		  			<tr class="danger">
		  				<td colspan="${user.role == 'manager'?'9':'8' }" align="center">暂无数据</td>
		  			</tr>
		  		</c:when>
		  		<c:otherwise>
				    <c:forEach items="${bookList }" var="book">
					  	<tr>
					  		<td><a href="javascript:void(0);" data-toggle="tooltip" data-placement="top" title="详情" onclick="details('${book.id}')">${book.id }</a></td>
					  		<td>${book.title }</td>
 							<c:if test="${user.role == 'manager' }">
					  			<td>${book.teacher.teacherName }</td>
					  		</c:if>
					  		<td>${book.style }</td>
					  		<td><fmt:formatDate value="${book.publishDate }" type="date"/></td>
					  		<td>${book.wordCount } 万字</td>
					  		<td>${book.isEditor == 0?'否':'是' }</td>
					  		<td>${book.createDate }</td>
					  		<td>
					  		<c:choose>
				  				<c:when test="${user.role == 'manager' }">
				  					<button type="button" class="btn btn-success btn-xs" onclick="details('${book.id}')" >查看</button>
				  				</c:when>
				  				<c:otherwise>
						  			<button type="button" class="btn btn-warning btn-xs" onclick="toUpdate('${book.id}');" >修改</button>
						  			<button type="button" class="btn btn-danger btn-xs" onclick="doDel('${book.type }', '${book.id}');">删除</button>
				  				</c:otherwise>
					  		</c:choose>
					  		</td>
					  	</tr>
					</c:forEach>
		  		</c:otherwise>
		  	</c:choose>
		  </table>
		  <div class="well well-sm">
			  <c:out value="${page }" escapeXml="false"/> 
		  </div>
		  </div>
		  </form:form>
	  	</div>
	 </div>
	</div>
  </div>
  <c:import url="../footer.jsp" />
</body>
</html>