<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>WebliveBroadcast</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<!-- //for-mobile-apps -->
<link href="main/css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<!-- pop-up -->
<link href="main/css/popuo-box.css" rel="stylesheet" type="text/css"
	media="all" />
<!-- //pop-up -->
<link href="main/css/easy-responsive-tabs.css" rel='stylesheet'
	type='text/css' />
<link rel="stylesheet" type="text/css" href="main/css/zoomslider.css" />
<link rel="stylesheet" type="text/css" href="main/css/style.css" />
<link href="main/css/font-awesome.css" rel="stylesheet">
<script type="text/javascript" src="main/js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700'
	rel='stylesheet' type='text/css'>
<link
	href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900"
	rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700'
	rel='stylesheet' type='text/css'>

<link rel="stylesheet" type="text/css" href="play/css/reset.css" />
<link rel="stylesheet" type="text/css" href="play/css/willesPlay.css" />
<script src="play/js/jquery-1.11.3.min.js" type="text/javascript"
	charset="utf-8"></script>
<script src="play/js/willesPlay.js" type="text/javascript"
	charset="utf-8"></script>

<link rel="stylesheet" href="asset/css/danmuplayer.css">
<script type="text/javascript" src="asset/js/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="asset/js/danmuplayer.js"></script>

<!-- 排行榜表 -->
<link rel="stylesheet" type="text/css" href="main/css/table-style.css" />
<link rel="stylesheet" href="main/css/list.css" type="text/css"
	media="all" />
<!-- //排行榜 -->
<!-- 上面为直播页面所有， 下面为登录注册界面-->
<!-- //custom-theme -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- js -->
<script src="js/jquery-1.9.1.min.js"></script>
<!--// js -->
<link rel="stylesheet" type="text/css" href="css/easy-responsive-tabs.css " />
 <link href="//fonts.googleapis.com/css?family=Questrial" rel="stylesheet">

<title>Insert title here</title>

<%
	String username = (String) request.getAttribute("username");
	String password = (String) request.getAttribute("password");
	
%>
<script>

var wsocket;
var serviceLocation = "ws://localhost:8080/WebLiveBroadcast/live/";
var $nickName;
var $message;
var $letter;
var $chatWindow;//？？？？？
var room = '';

var picture_data = '';
var audio_data = '';
var audio2_data = '';
var video_data = '';
var mp3Blob;
var name="<%=username%>";


function onMessageReceived(evt) {
	var msg = JSON.parse(evt.data); // native API

	if(msg.message != ""&&msg.message != ""){
		if(msg.receiver == ""){               //广播
			//当信息为图片时
			if(msg.filetype == "picture"){
				if(msg.ifNext == "y"){
					picture_data += msg.message;
				}else{
					picture_data += msg.message;
					var messageItem = '<div class="content-time">' + msg.received
						+ '</div><br /><li><div class="content-name"><font color="blue">' + msg.sender
						+ '</font></div><br /><div class="content-message">'
						+ '<img src="' + picture_data + '" height="auto" max-width="200px" />'
						+ '</div></li>';
							
					$(messageItem).appendTo('#message-list');
		            // 把滚动条滚动到底部
			        $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);//??????????????????
			        picture_data = '';
				}
			//当信息为录得音频时
			} else if(msg.filetype == "audio"){
				if(msg.ifNext == "y"){
					audio_data += msg.message;
				}else{
					audio_data += msg.message;
					var messageItem = '<div class="content-time">' + msg.received
						+ '</div><br /><li><div class="content-name"><font color="blue">' + msg.sender
						+ '</font></div><br /><div class="content-message">'
						+ '<audio controls src="' + audio_data + '" ></audio>'
						+ '</div></li>';
							
					$(messageItem).appendTo('#message-list');
		            // 把滚动条滚动到底部
			        $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
			        audio_data = '';
				}
			//当信息为普通音频时
			} else if(msg.filetype == "audio2"){
				if(msg.ifNext == "y"){
					audio2_data += msg.message;
				}else{
					audio2_data += msg.message;
					var messageItem = '<div class="content-time">' + msg.received
						+ '</div><br /><li><div class="content-name"><font color="blue">' + msg.sender
						+ '</font></div><br /><div class="content-message">'
						+ '<audio controls src="' + audio2_data + '" ></audio>'
						+ '</div></li>';
							
					$(messageItem).appendTo('#message-list');
		            // 把滚动条滚动到底部
			        $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
			        audio2_data = '';
				}
			//当信息为视频时
			} else if(msg.filetype == "video"){
				if(msg.ifNext == "y"){
					video_data += msg.message;
				}else{
					video_data += msg.message;
					var messageItem = '<div class="content-time">' + msg.received
						+ '</div><br /><li><div class="content-name"><font color="blue">' + msg.sender
						+ '</font></div><br /><div class="content-message">'
						+ '<button value="' + video_data + '" onclick="showVideo(this);" >' + msg.filename + '</button>'
						+ '</div></li>';
							
					$(messageItem).appendTo('#message-list');
		            // 把滚动条滚动到底部
			        $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
			        video_data = '';
				}
			} else{
				//当信息发送者为主播时
				if(msg.sender == "bdc"){
					var messageItem = '<div class="content-time">' + msg.received
						+ '</div><br /><li><div class="content-name"><font color="blue">' + msg.sender
						+ '</font></div><br /><div class="content-message">' + msg.message
						+ '</div></li>';
					$(messageItem).appendTo('#message-list');
	                // 把滚动条滚动到底部
	                $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
	            //当信息发送者不是主播时
				}else{
					var messageItem = '<div class="content-time"><span>' + msg.sender+": "
					 +msg.message
					+"      " +  msg.received
					+ '</span></div>';
					$(messageItem).appendTo('#message-list');
	                // 把滚动条滚动到底部
	                $(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
				}
			}
		}else{//不是广播
			
			if(msg.receiver == name){  //当前用户为接收用户               
				var messageItem = '<tr><td>'+ msg.sender+':  '+msg.message+'   '+msg.received+ '<td><tr>';
			//当信息面对所有用户时
			}else if(msg.sender==name){         //-------------------------------------------------这一段可能有问题
				var messageItem ='<tr><td>'+"to"+ msg.receiver+':  '+msg.message+'   '+msg.received+ '<td><tr>';
			}
			$(messageItem).appendTo('#letterList');
		}
	}
	
	//显示当前用户数及用户名
	var message2 = '<tr><td>audience number:  ' + msg.sum + '<td><tr>';
	var names2 = msg.names.split('|');
	
	for(var i=0; i<names2.length-1; i++){
		message2 += '<tr><td>' + names2[i] + '<td><tr>'
	}
	var message3 = "";
	for(var i=0; i<names2.length-1; i++){
		if(names2[i] !=name){                 //不是自己的名字
			message3 += '<option>' + names2[i] + '</option>'
		}
	}
	
	$('#peopleList').empty();    

	$(message2).appendTo('#peopleList');
	
	$('#peopleOption').empty();//私信对话的下拉框
	$(message3).appendTo('#peopleOption');

}

//广播信息
function sendMessage() {
	
    var msg = '{"message":"' + $message.val() + '", "sender":"'
	+name+ '", "received":"","receiver":"","filename":"","filetype":"1", "ifNext":"n"}';
	wsocket.send(msg);
	$message.val('').focus();
}

//点对点发送信息函数
function sendToOne() {
	var options=$("#peopleOption option:selected");
	var msg = '{"message":"' + $letter.val() + '", "sender":"'
			+ name + '", "received":"", "receiver":"' + options.text() + '","filename":"","filetype":"1", "ifNext":"n"}';
	wsocket.send(msg);
	$letter.val('').focus();
}

//发送文件总函数
function sendFile(){
    var inputElement = document.getElementById("theFile");
	var fileList = inputElement.files;
	
	for( var i = 0 ; i < fileList.length ; i++ ){
		
		var reader = new FileReader();
		reader.onload = function ( event ) {
       		var message = this.result;
       		var amessage = "";
       		var a = message.length/2048-1;
       		var i = 0;
       		
			
	        if (/video\/\w+/.test(fileList[i].type)) {//如果是视频
	        	for (; i < a; i++) {
					amessage = message.substring(i * 2048, i * 2048 + 2048);
					var msg = '{"message":"'
							+ amessage
							+ '", "sender":"'
							+ name
							+ '", "received":"", "receiver":"","filename":"", "filetype":"video", "ifNext":"y"}';
					wsocket.send(msg);
				}
				amessage = message.substring(i * 2048);
				var msg = '{"message":"'
						+ amessage
						+ '", "sender":"'
						+ name
						+ '", "received":"", "receiver":"","filename":"'
						+ inputElement.value.substring(inputElement.value
								.lastIndexOf('\\') + 1)
						+ '", "filetype":"video", "ifNext":"n"}';

				} else if (/image\/\w+/.test(fileList[i].type)){//如果是图片

					for (; i < a; i++) {
						amessage = message.substring(i * 2048, i * 2048 + 2048);
						var msg = '{"message":"'
								+ amessage
								+ '", "sender":"'
								+ name
								+ '", "received":"", "receiver":"","filename":"", "filetype":"picture", "ifNext":"y"}';
						wsocket.send(msg);
					}
					amessage = message.substring(i * 2048);
					var msg = '{"message":"'
							+ amessage
							+ '", "sender":"'
							+ name
							+ '", "received":"", "receiver":"","filename":"", "filetype":"picture", "ifNext":"n"}';//最后一部分
				}else if (/audio\/\w+/.test(fileList[i].type)){//如果是音频
					for (; i < a; i++) {
						amessage = message.substring(i * 2048, i * 2048 + 2048);
						var msg = '{"message":"'
								+ amessage
								+ '", "sender":"'
								+ name
								+ '", "received":"", "receiver":"","filename":"", "filetype":"audio2", "ifNext":"y"}';
						wsocket.send(msg);
					}
					amessage = message.substring(i * 2048);
					var msg = '{"message":"'
							+ amessage
							+ '", "sender":"'
							+ name
							+ '", "received":"", "receiver":"","filename":"", "filetype":"audio2", "ifNext":"n"}';
				}
				wsocket.send(msg);
			};

			reader.readAsDataURL(fileList[i]);
		}

	}

	function connectToChatserver() {
		wsocket = new WebSocket(serviceLocation + room);//加上room的特定url的websocket
		wsocket.onmessage = onMessageReceived;//？
		wsocket.onopen = function() {//用于加载初始信息
			var msg = '{"message":"", "sender":"' + name 
				+ '", "received":"","receiver":"","filename":"","filetype":"1", "ifNext":"n"}';
			wsocket.send(msg);
		}
	}

	$(document).ready(function() {//当 DOM（文档对象模型） 已经加载，并且页面（包括图像）已经完全呈现时，会发生 ready 事件。
		//$nickName = $('#nickname');
		$message = $('#message');
		$chatWindow = $('#response');
		$letter=$('#txtletter');

		$('#room-page').hide();
		$('#Live-room').show();
        
		if(name=="anchor1"){
			room = 'Room1';
		}else if(name=="anchor2"){
			room = 'Room2';
		}else if(name=="anchor3"){
			room = 'Room3';
		}else if(name=="anchor4"){
			room = 'Room4';
		}else if(name=="anchor5"){
			room = 'Room5';
		}
		connectToChatserver();//连接服务器
		$('#peopleList').show();
		$('#letterList').hide();
		
		
		//enterRoom 响应
		$('#enterRoom1').click(function(evt) {
			evt.preventDefault();//preventDefault() 方法阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
			room = 'Room1';
			connectToChatserver();//连接服务器
			$('#room-page').hide();
			$('#Login-register').hide();
			$('#Live-room').show();
			
			$('#peopleList').show();
			$('#letterList').hide();
			
			$message.focus();
		});

		//enterRoom 响应
		$('#enterRoom2').click(function(evt) {
			evt.preventDefault();//preventDefault() 方法阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
			room = 'Room2';
			connectToChatserver();//连接服务器
			$('#room-page').hide();
			$('#Login-register').hide();
			$('#Live-room').show();
			
			$('#peopleList').show();
			$('#letterList').hide();
			
			$message.focus();
		});

		
		// 响应
		$('#toLetter').click(function(evt) {
			evt.preventDefault();//preventDefault() 方法阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
			$('#peopleList').hide();
			$('#letterList').show();
		});
		
		// 响应
		$('#toPeople').click(function(evt) {
			evt.preventDefault();//preventDefault() 方法阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
			$('#peopleList').show();
			$('#letterList').hide();
		});
		
		// 响应
		$('#do-chat').click(function(evt) {
			evt.preventDefault();//preventDefault() 方法阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
			sendMessage();
		});
		
		// 响应
		$('#sendTo').click(function(evt) {
			evt.preventDefault();//preventDefault() 方法阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
			sendToOne();
		});
		

		$('#send-file').click(function() {
			$('#theFile').trigger('click');
		});

		// 响应
		$('#start-video').click(function(evt) {
			evt.preventDefault();//preventDefault() 方法阻止元素发生默认的行为（例如，当点击提交按钮时阻止对表单的提交）
			startVideo();
			draw();
		});
	});
</script>

</head>
<body>

	<div id="room-page">
		<!--/main-header-->
		<!--/banner-section-->
		<div id="demo-1" class="banner-inner">
			<div class="banner-inner-dott">
				<!--/header-w3l-->
				<div class="header-w3-agileits" id="home">
					<div class="inner-header-agile part2">
						<nav class="navbar navbar-default">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse"
								data-target="#bs-example-navbar-collapse-1">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<h1>
								<a href="index.jsp"><span>Web</span>LiveBroadcast</a>
							</h1>
						</div>
						<div class="clearfix"></div>
						</nav>
					</div>
				</div>
				<!--//header-w3l-->
			</div>
		</div>
		<!--/banner-section-->
		<!--//main-header-->
		<!--/banner-bottom-->
		<div class="w3_breadcrumb">
			<div class="breadcrumb-inner">
				<ul>
					<li><a href="index.jsp">退出</a><i>//</i></li>
					<li>主页</li>
				</ul>
			</div>
		</div>
		<!-- //breadcrumb -->

		<!--/content-inner-section-->
		<div class="w3_content_agilleinfo_inner">
			<div class="agile_featured_movies">
				<!--/comedy-movies-->
				<h3 class="agile_w3_title hor-t">
					直播<span>间</span>
				</h3>
				<div class="wthree_agile-requested-movies tv-movies">

					<div class="col-md-2 w3l-movie-gride-agile requested-movies">
						<a id="enterRoom1" class="hvr-sweep-to-bottom"><img
							style="height: 180px; width: 300px" src="main/images/c1.jpg"
							title="Movies Pro" class="img-responsive" alt=" ">
							<div class="w3l-action-icon">
								<i class="fa fa-play-circle-o" aria-hidden="true"></i>
							</div> </a>
						<div class="mid-1 agileits_w3layouts_mid_1_home">
							<div class="w3l-movie-text">
								<h6>
									<a href="single.html">直播间一</a>
								</h6>
							</div>
							<div class="mid-2 agile_mid_2_home">
								<p>2016</p>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="ribben one">
							<p>NEW</p>
						</div>
					</div>

					<div class="col-md-2 w3l-movie-gride-agile requested-movies">
						<a id="enterRoom2" class="hvr-sweep-to-bottom"><img
							style="height: 180px; width: 300px" src="main/images/c2.jpg"
							title="Movies Pro" class="img-responsive" alt=" ">
							<div class="w3l-action-icon">
								<i class="fa fa-play-circle-o" aria-hidden="true"></i>
							</div> </a>
						<div class="mid-1 agileits_w3layouts_mid_1_home">
							<div class="w3l-movie-text">
								<h6>
									<a href="single.html">Zootopia</a>
								</h6>
							</div>
							<div class="mid-2 agile_mid_2_home">
								<p>2016</p>
								<div class="block-stars">
									<ul class="w3l-ratings">
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-half-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
									</ul>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="ribben one">
							<p>NEW</p>
						</div>
					</div>
					<div class="col-md-2 w3l-movie-gride-agile requested-movies">
						<a id="enterRoom3" class="hvr-sweep-to-bottom"><img
							style="height: 180px; width: 300px" src="main/images/c3.jpg"
							title="Movies Pro" class="img-responsive" alt=" ">
							<div class="w3l-action-icon">
								<i class="fa fa-play-circle-o" aria-hidden="true"></i>
							</div> </a>
						<div class="mid-1 agileits_w3layouts_mid_1_home">
							<div class="w3l-movie-text">
								<h6>
									<a href="single.html">Dirty Grandpa</a>
								</h6>
							</div>
							<div class="mid-2 agile_mid_2_home">
								<p>2016</p>
								<div class="block-stars">
									<ul class="w3l-ratings">
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-half-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
									</ul>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="ribben one">
							<p>NEW</p>
						</div>
					</div>

					<div class="col-md-2 w3l-movie-gride-agile requested-movies">
						<a id="enterRoom4" class="hvr-sweep-to-bottom"><img
							style="height: 180px; width: 300px" src="main/images/c4.jpg"
							title="Movies Pro" class="img-responsive" alt=" ">
							<div class="w3l-action-icon">
								<i class="fa fa-play-circle-o" aria-hidden="true"></i>
							</div> </a>
						<div class="mid-1 agileits_w3layouts_mid_1_home">
							<div class="w3l-movie-text">
								<h6>
									<a href="single.html">Neighbors 2 </a>
								</h6>
							</div>
							<div class="mid-2 agile_mid_2_home">
								<p>2016</p>
								<div class="block-stars">
									<ul class="w3l-ratings">
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-half-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
									</ul>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="ribben one">
							<p>NEW</p>
						</div>
					</div>

					<div class="col-md-2 w3l-movie-gride-agile requested-movies">
						<a id="enterRoom5" class="hvr-sweep-to-bottom"><img
							style="height: 180px; width: 300px" src="main/images/c5.jpg"
							title="Movies Pro" class="img-responsive" alt=" ">
							<div class="w3l-action-icon">
								<i class="fa fa-play-circle-o" aria-hidden="true"></i>
							</div> </a>
						<div class="mid-1 agileits_w3layouts_mid_1_home">
							<div class="w3l-movie-text">
								<h6>
									<a href="single.html">Neighbors 2 </a>
								</h6>
							</div>
							<div class="mid-2 agile_mid_2_home">
								<p>2016</p>
								<div class="block-stars">
									<ul class="w3l-ratings">
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-half-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-o"
												aria-hidden="true"></i></a></li>
									</ul>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="ribben one">
							<p>NEW</p>
						</div>
					</div>

					<div class="clearfix"></div>
				</div>
				<!--//comedy-movies-->
				<div class="blog-pagenat-wthree">
					<ul>
						<li><a class="frist" href="#">上一页</a></li>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>

						<li><a class="last" href="#">下一页</a></li>
					</ul>

					<!--//requested-movies-->
				</div>
			</div>
		</div>
		<!--//content-inner-section-->

		<!--/footer-bottom-->
		<!--尾部-->
		<div class="contact-w3ls" id="contact"></div>
		<div class="w3agile_footer_copy">
			<p>你愁啥在线视频网站</p>
		</div>
	</div>
	<!-- 登录注册界面 -->


	<!-- 直播界面 -->
	<div id="Live-room">
		<!--/main-header-->
		<!--/banner-section-->
		<div id="demo-1" class="banner-inner">
			<div class="banner-inner-dott">
				<!--/header-w3l-->
				<div class="header-w3-agileits" id="home">
					<div class="inner-header-agile part2">
						<nav class="navbar navbar-default">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse"
								data-target="#bs-example-navbar-collapse-1">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<h1>
								<a href="index.jsp"><span>Web</span>LiveBroadcast</a>
							</h1>
						</div>
						<div class="clearfix"></div>
						</nav>
					</div>
				</div>
				<!--//header-w3l-->
			</div>
		</div>
		<!--/banner-section-->
		<!--//main-header-->
		<!--/banner-bottom-->

		<div class="w3_breadcrumb">
			<div class="breadcrumb-inner">
				<ul>
					<li><a href="index.jsp">退出</a><i>//</i></li>

					<li>播放</li>
				</ul>
			</div>
		</div>
		<!-- //breadcrumb -->
		<!--/content-inner-section-->


		<div class="w3_content_agilleinfo_inner">
			<div class="agile_featured_movies">
				<div class="inner-agile-w3l-part-head">
					<h3 class="w3l-inner-h-title">直播</h3>
				</div>
				<div class="latest-news-agile-info">
					<div class="col-md-8 latest-news-agile-left-content">


						<!--直播块------->
						<div class="single video_agile_player">

							<!--视频直播块------->
							<div style="float: center">
								<video autoplay id="video" style="width:420px;height:240px"></video>
								<br>


								<canvas id="output" style="display:none"></canvas>

								<script type="text/javascript" charset="utf-8">
								    var videoRoom='';
								    var name2="<%=username%>";
								    if(name2=="anchor1"){
								    	videoRoom = 'Room1';
									}else if(name2=="anchor2"){
										videoRoom = 'Room2';
									}else if(name2=="anchor3"){
										videoRoom = 'Room3';
									}else if(name2=="anchor4"){
										videoRoom = 'Room4';
									}else if(name2=="anchor5"){
										videoRoom = 'Room5';
									}
									var socket = new WebSocket("ws://"
											+ document.domain
											+ ":8080/WebLiveBroadcast/liveServer/"+videoRoom);
									document.write("ws://"
											+ document.domain
											+ ":8080/WebLiveBroadcast/liveServer/"+videoRoom);
									var back = document
											.getElementById("output");
									var backcontext = back.getContext("2d");//getContext() 方法返回一个用于在画布上绘图的环境。
									//参数 contextID 指定了您想要在画布上绘制的类型。当前唯一的合法值是 "2d"，它指定了二维绘图，并且导致这个方法返回一个环境对象，该对象导出一个二维绘图 API。
									var video = document
											.getElementById("video");

									var success = function(stream) {
										video.src = window.URL
												.createObjectURL(stream);//video.src是生成的对象URL.通过这个URL,可以获取到所指定文件的完整内容.
										//src 属性规定要播放的视频的 URL
									}

									/*socket.onopen = function() {
										draw();
									}*/

									var draw = function() {
										try {
											backcontext.drawImage(video, 0, 0,
													back.width, back.height);
										} catch (e) {
											if (e.name == "NS_ERROR_NOT_AVAILABLE") {
												return setTimeout(draw, 100);
											} else {
												throw e;
											}
										}
										if (video.src) {
											socket.send(back.toDataURL(
													"image/jpeg", 0.2));
										}
										setTimeout(draw, 100);
									}
									function startVideo(){
									navigator.getUserMedia = navigator.getUserMedia
											|| navigator.webkitGetUserMedia
											|| navigator.mozGetUserMedia
											|| navigator.msGetUserMedia;
									navigator.getUserMedia({
										video : true,
										audio : false
									}, success, console.log);
									}
								</script>

								<div class="single-agile-shar-buttons">
									<h5>视频直播</h5>
								</div>
							</div>
						</div>




						<br />
						<div class="single-agile-shar-buttons">
							<h5>聊天室</h5>

						</div>
                        <table id="response" class="table table-bordered"></table>
                        <div class="chat-content-container">
			                  <ul id="message-list"></ul>
		               </div>
						<div class="all-comments-info">
							<h5>LEAVE A COMMENT</h5>
							<div class="agile-info-wthree-box">
								<form>
									<div class="col-md-6 form-info">
										<textarea id="message" placeholder="Message" required="required"></textarea>
										<input id="do-chat" type="submit" value="SEND">

									</div>
									<div class="col-md-6 form-info">
										<input id="theFile" class="forbutton" onchange="sendFile();"
			                               type="file" accept=".png,.jpg,.jpeg,.mp3,.wav,.wma,.mp4,.avi" style="display: none;"
			                                name="theFile" />
			                             <input id="send-file" type="submit" value="Send File">  
										<br /> 
										<input id="start-video" type="submit" value="start video">

									</div>
								
									<div class="clearfix"></div>


								</form>
							</div>
						</div>
					</div>
					<div class="col-md-4 latest-news-agile-right-content">
						<table id="table-breakpoint">
							<thead>
								<tr>
									<th id="toPeople">观众</th>
									<th id="toLetter">消息</th>
								</tr>
							</thead>
							<tbody id="peopleList">
								

							</tbody>
							<tbody id="letterList">
								

							</tbody>
							
						</table>

						<div class="all-comments-info">
							<h5>私信用户</h5>
							<div class="agile-info-wthree-box">
								<form>
									<div class="col-md-6 form-info">
										<select id="peopleOption" style="height: 40px; width: 260px">
											<option value="volvo">Volvo</option>
											<option value="saab">Saab</option>
											<option value="opel">Opel</option>
											<option value="audi">Audi</option>
										</select> <br /> <br />
										<textarea id="txtletter" placeholder="Message" required="required"
											style="width: 260px"></textarea>
										<input id="sendTo" type="submit" value="SEND">

									</div>
									<div class="col-md-6 form-info"></div>
									<div class="clearfix"></div>


								</form>
							</div>
						</div>

					</div>
					<div class="clearfix"></div>
				</div>

			</div>
		</div>
		<!--//content-inner-section-->


		<!--/footer-bottom-->
		<!--尾部-->
		<div class="contact-w3ls" id="contact"></div>
		<div class="w3agile_footer_copy">
			<p>WebLiveBroadcast</p>
		</div>
		<!--回到最顶端-->
		<a href="#home" id="toTop" class="scroll" style="display: block;">
			<span id="toTopHover" style="opacity: 1;"> </span>
		</a>

		<script src="js/jquery-1.11.1.min.js"></script>
		<!-- Dropdown-Menu-JavaScript -->
		<script>
		$(document).ready(function() {
			$(".dropdown").hover(function() {
				$('.dropdown-menu', this).stop(true, true).slideDown("fast");
				$(this).toggleClass('open');
			}, function() {
				$('.dropdown-menu', this).stop(true, true).slideUp("fast");
				$(this).toggleClass('open');
			});
		});
	</script>
		<!-- //Dropdown-Menu-JavaScript -->


		<script type="text/javascript" src="js/jquery.zoomslider.min.js"></script>
		<!-- search-jQuery -->
		<script src="js/main.js"></script>
		<script src="js/simplePlayer.js"></script>
		<script>
		$("document").ready(function() {
			$("#video").simplePlayer();
		});
	</script>
		<script>
		$("document").ready(function() {
			$("#video1").simplePlayer();
		});
	</script>
		<script>
		$("document").ready(function() {
			$("#video2").simplePlayer();
		});
	</script>
		<script>
		$("document").ready(function() {
			$("#video3").simplePlayer();
		});
	</script>

		<!-- pop-up-box -->
		<script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
		<!--//pop-up-box -->

		<div id="small-dialog1" class="mfp-hide">
			<iframe
				src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
		</div>
		<div id="small-dialog2" class="mfp-hide">
			<iframe
				src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
		</div>
		<script>
		$(document).ready(function() {
			$('.w3_play_icon,.w3_play_icon1,.w3_play_icon2').magnificPopup({
				type : 'inline',
				fixedContentPos : false,
				fixedBgPos : true,
				overflowY : 'auto',
				closeBtnInside : true,
				preloader : false,
				midClick : true,
				removalDelay : 300,
				mainClass : 'my-mfp-zoom-in'
			});

		});
	</script>
		<script src="js/easy-responsive-tabs.js"></script>
		<script>
$(document).ready(function () {
$('#horizontalTab').easyResponsiveTabs({
type: 'default', //Types: default, vertical, accordion           
width: 'auto', //auto or any width like 600px
fit: true,   // 100% fit in a container
closed: 'accordion', // Start closed if in accordion view
activate: function(event) { // Callback function if tab is switched
var $tab = $(this);
var $info = $('#tabInfo');
var $name = $('span', $info);
$name.text($tab.text());
$info.show();
}
});
$('#verticalTab').easyResponsiveTabs({
type: 'vertical',
width: 'auto',
fit: true
});
});
</script>
		<link href="css/owl.carousel.css" rel="stylesheet" type="text/css"
			media="all">
		<script src="js/owl.carousel.js"></script>
		<script>
	$(document).ready(function() { 
		$("#owl-demo").owlCarousel({
	 
		 autoPlay: 3000, //Set AutoPlay to 3 seconds
		  autoPlay : true,
		   navigation :true,

		  items : 5,
		  itemsDesktop : [640,4],
		  itemsDesktopSmall : [414,3]
	 
		});
	 
	}); 
</script>

		<!--/script-->
		<script type="text/javascript" src="js/move-top.js"></script>
		<script type="text/javascript" src="js/easing.js"></script>

		<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},900);
				});
			});
</script>
		<script type="text/javascript">
						$(document).ready(function() {
							/*
							var defaults = {
					  			containerID: 'toTop', // fading element id
								containerHoverID: 'toTopHover', // fading element hover id
								scrollSpeed: 1200,
								easingType: 'linear' 
					 		};
							*/
							
							$().UItoTop({ easingType: 'easeOutQuart' });
							
						});
					</script>
		<!--end-smooth-scrolling-->
		<script src="js/bootstrap.js"></script>
	</div>
</body>
</html>