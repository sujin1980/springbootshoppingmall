<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>欢迎登录后台管理系统</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
   </head> 

	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" name="viewport">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css" />
	<link rel="stylesheet" href="../plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="../css/style.css">
	
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
<script>
function addRow(){
	window.open("/order/toAdd2");
}

function getOrderById(){
 
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
		   "id":  $("title").val()
		},
		url : '/order/getOrderById.do',
		success : function(data) {
			 alert("ok");
			 
			 if (data != null) { 
				 $("orderlist").html("");
				 var tbodyhtmlod = '';
			
				 for(var i= 0; i< data.length; i++){
					 tbodyhtmlod += '<tr class="odd gradeX">';
					  tbodyhtmlod += '<td> <input id=' + data[i].id + 'class="odd gradeX" type="checkbox" name="ordercheckbox" '
					      + 'style="visibility: visible" onclick="ordersclickcheck(this)"> </td>';
					  tbodyhtmlod += '<td> ' + data[i].id   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].payment + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].paymentType + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].status + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].paymentTime   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].consignTime   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].endTime + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].clientName   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].clientChineseName   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].receiverMobile   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].receiverAreaName + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].remarks + '</td>';
					  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
					      '<a href="<%=basePath%>/order/toEdit2?id=' + data[i].id + '">查看</a> </td> </tr>';
				 }
				 console.log(tbodyhtmlod);
				 $("#orderlist").html(tbodyhtmlod);
				 window.location.reload();
			 }
			 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
			 window.location.reload();
		}
	});
}

function deleteRows(){
    var che = document.getElementsByName("ordercheckbox");  
    var idlist = {};
    
    for(var i=0; i < che.length;i++){  
        if(che[i].checked == true){
        	idlist[i] = che[i].id;
        }
    }  
    
  
    $.ajax({
    	dataType: "json",  
        type: "POST",
		data: idlist,
		url : '/order/deleteOrders.do',
		success : function(data) {
			 alert("ok");
			 window.location.reload();
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
			 window.location.reload();
		}
	});
    
}

function allcheck() {
	var allche = document.getElementById("selall");  
    var che = document.getElementsByName("ordercheckbox");  
    if(allche.checked == true){  
        for(var i=0;i<che.length;i++){  
            che[i].checked="checked";  
        }  
    }else{  
        for(var i=0;i<che.length;i++){  
            che[i].checked=false;  
        }  
    }  
 }
   
 function orderclickcheck(obj) {
	if(obj.checked==false){  
        var allche = document.getElementById("selall");  
        allche.checked = false;
    }
}
     
function  editRow(obj){
    var i = 1;
	alert(i);
	return;	 
}

 </script>
 
<body class="easyui-layout">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
		<li><a href="javascript:void(0);">首页</a></li>
		<li><a href="javascript:void(0);">订单管理</a></li>
		<li><a href="javascript:void(0);">订单</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<div class="tools">
		<ul class="seachform">
		<li><label>订单号</label><input id="title" name="title" type="text" class="scinput" /></li>
		<li><label>&nbsp;</label><input name="" type="button" onclick="getOrderById();" class="scbtn" value="查询"/></li>
		</ul>
		<ul class="toolbar">
		</ul>
		<ul class="toolbar1">
		</ul>
		</div>
	</div>
	
	<div class="tools">
		<ul class="toolbar">
			<button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 新建</button>
	        <button type="button" class="btn btn-default" title="删除"  onclick="deleteRows()"><i class="fa fa-trash-o"></i> 删除</button>
	        <button type="button" class="btn btn-default" title="刷新" onclick="window.location.reload();"><i class="fa fa-refresh"></i> 刷新</button>
		</ul>
	</div>
	
	<div id="tt" class="easyui-tabs" data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
		<div title="<span class='tt-inner'>订单列表<br></span>" style="padding:10px">
			<table class="table table-border table-bordered table-hover table-bg">
				<thead>
					<tr class="text-c">
					    <th style="width: 1%">
		                    <input id="selall" onclick="allcheck()" type="checkbox"/>
		                </th>
		                <th style="width: 8%">订单号</th>
						<th style="width: 8%">金额</th>
						<th style="width: 8%">支付类型</th>
						<th style="width: 8%">状态</th>
						<th style="width: 8%">付款时间</th>
						<th style="width: 8%">发货时间</th>
						<th style="width: 8%">交易完成时间</th>
						<th style="width: 8%">买家名称</th>
						<th style="width: 8%">中文名称</th>
						<th style="width: 8%">买家联系方式</th>
						<th style="width: 8%">买家地址</th>
						<th style="width: 8%">描述</th>
						<th style="width: 8%">操作</th>
					</tr>
				</thead>
				<tbody id="orderlist" >
					<c:forEach items="${ orders }" var="order">
						<tr class="odd gradeX">
						    <td><input id=${order.id} class="odd gradeX" type="checkbox" name="ordercheckbox" style="visibility: visible" onclick="ordersclickcheck(this)"> </td>
						    <td> ${order.id} </td>
							<td> ${order.payment} </td>
							<td> ${order.paymentType} </td>
							<td> ${order.status} </td>
							<td> ${order.paymentTime} </td>
							<td> ${order.consignTime} </td>
							<td> ${order.endTime} </td>
							<td> ${order.clientName} </td>
							<td> ${order.clientChineseName} </td>
							<td> ${order.receiverMobile} </td>
							<td> ${order.receiverAreaName} </td>
							<td> ${order.remarks} </td>
							<td class="text-center">                                          
			             	  <a href="<%=basePath%>/order/toEdit2?id=${order.id}">查看</a></button>   
			                </td>
						</tr>
					</c:forEach>				
			   </tbody>
			</table>
			<span><div class="easyui-pagination" data-options="total:20" id="pp" style="width:80%;margin-left:40px;"></div></span>
		</div>
	</div>
	
</body>

</html>