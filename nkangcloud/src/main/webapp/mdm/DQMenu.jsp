<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page import="java.util.*" %>
<%@ page import="com.nkang.kxmoment.baseobject.MdmDataQualityView" %>
<%@ page import="com.nkang.kxmoment.baseobject.GeoLocation" %>
<%@ page import="com.nkang.kxmoment.baseobject.ClientInformation" %>    
<%@ page import="com.nkang.kxmoment.util.RestUtils"%>
<%@ page import="com.nkang.kxmoment.baseobject.WeChatUser"%>
<%@ page import="com.nkang.kxmoment.util.Constants"%>
<%@ page import="java.net.URLEncoder"%>

<%	
String AccessKey =RestUtils.callGetValidAccessKey();
String uid = request.getParameter("UID");
WeChatUser wcu = RestUtils.getWeChatUserInfo(AccessKey, uid);
List<String > addressInfo = RestUtils.getUserCurLocWithLatLngV2(wcu.getLat(),wcu.getLng());
String userCity="上海市";
String userState="上海市";
if(addressInfo != null && addressInfo.size()>0){
	if(!addressInfo.get(0).trim().isEmpty() && addressInfo.get(0)!= null){
		userState = addressInfo.get(0);
	}
	if(!addressInfo.get(1).trim().isEmpty() && addressInfo.get(1)!= null){
		userCity = addressInfo.get(1);
	}
}
userCity="上海市";
userState="上海市";
List<String> lst = RestUtils.CallGetJSFirstSegmentAreaListFromMongo(userState);
String userName = "Visitor";
if(wcu.getNickname() != null && wcu.getNickname() != ""){
	userName = wcu.getNickname();
}
String userImage = "../MetroStyleFiles/gallery.jpg";
if(wcu.getHeadimgurl() !=null && wcu.getHeadimgurl() != ""){
	userImage = wcu.getHeadimgurl();
}

%>
<!DOCTYPE html>
<html class=" js csstransitions">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MDM Makes it Matter</title> 
	<meta content="" name="hpe" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<link rel="icon" type="image/x-icon" href="../webitem/hpe.ico"/>
	<link rel="short icon" type="image/x-icon" href="../webitem/hpe.ico"/>
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/sonhlab-base.css"/>
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/metrotab-v2.css"/>
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/metro-bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/global-demo.css"/>	
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/animation-effects.css"/>		
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/openmes.css"/>
	<link rel="stylesheet" type="text/css" href="../nkang/c3.css"/>
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/sweetalert.css"/>
	<link rel="stylesheet" type="text/css" href="../MetroStyleFiles/CSS/pageLoad.css"/>

	<script type="text/javascript" src="../MetroStyleFiles/JS/jquery.min.2.1.1.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/JS/jquery.easing.min.13.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/JS/jquery.mousewheel.min.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/JS/jquery.jscrollpane.min.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/JS/jquery.masonry.min.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/JS/modernizr-transitions.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/JS/metrotab-v2.min.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/JS/openmes.min.js"></script>
	<script type="text/javascript" src="../MetroStyleFiles/sweetalert.min.js"></script>
    <script type="text/javascript" src="../nkang/liquidFillGauge.js"></script>
	<script type="text/javascript" src="../nkang/Chart.js"></script>
	<script type="text/javascript" src="../nkang/gauge.js"></script>
	<script type="text/javascript" src="../nkang/RadarChart.js"></script>

	<script type="text/javascript" src="../nkang/d3.v3.min.js"></script>
	<script type="text/javascript" src="../nkang/c3.min.js"></script>

	<script type="text/javascript">
		$(window).load(function() {
			$("#goaway").fadeOut("slow");
			$(".mes-openbt").openmes({ext: 'php'});
		});

	</script>
	
	<script type="text/javascript">

	$(document).ready(function() {
		$('.metrotabs').metrotabs({
				outeffect : 'swing',
				ineffect :	'swing',
				moveout : 'BottomOrRight', // TopOrLeft | BottomOrRight
				movein : 'TopOrLeft', // TopOrLeft | BottomOrRight
				outduration : 400,
				induration : 400,
				minibartitle: 'Master Data Lake Quality Grade',
				mtEffect : 'vertical' // vertical | horizontal | fade
			});
		// $("#conporlan").bind("click", loadChart4);
		//document.getElementById("conporlan").addEventListener('click',loadChart4,false);
		//var clickEvent = $("#conporlan").data('events')["click"];
		//alert(JSON.stringify(clickEvent));
		
	});

	function CommentMe(){
		swal(
				{
					title: "Dear <%= wcu.getNickname()%> Comment US!",   
					text: "Drop us a message and do things better together",   
					type: "input",   
					showCancelButton: true,   
					closeOnConfirm: false,   
					animation: "slide-from-top",   
					inputPlaceholder: "Write something" 
				}, 
				function(inputValue){
					inputVar = inputValue;
					if (inputValue === false) return false;      
					if (inputValue === "") {     
						swal.showInputError("You need to write something!");     
						return false;   
					}
					swal("Thank You!", "We will contact you soon", "success"); 
				}
			);
	}
	
	function OrganizationInformation(){
		swal("200M", <%= RestUtils.CallgetFilterTotalOPSIFromMongo("null","null","null") %>+" Organizations", "success");
	}
	
	function loadChart(obj){
		var chartobj = $("#chart3");
		$("#openfooter_loadC3").html(chartobj);
		chartobj.show();
	}
	
	
	function loadChart2(obj){
 		var chartobj = $("#chart2");
 		$("#openfooter_loadC2").append(chartobj);
		//$("#openfooter_loadC2").html(chartobj);
		chartobj.show();
     }
	
	function loadChartRadar(obj){
		var chartobj = $("#chart3Radar");
		$("#americano_loadChart").html(chartobj);
		chartobj.show();
	}
	
	function loadChart4(obj){
		var chartobj = $("#chart4");
		$("#conporlan_loadChart").html(chartobj);
		chartobj.show();
	}
	
	function loadChart5(obj){
		var chartobj = $("#chart5");
		$("#capuqino_loadChart").html(chartobj);
		chartobj.show();
	}
	
	function loadChartRadarWithDetail(obj){
		swal({   
			title: "Segment Area",   
			text: "Retrieving more industry distribution....",   
			type: "info",   
			showCancelButton: true,   
			closeOnConfirm: false,   
			showLoaderOnConfirm: true, }, 
			function(){   
				setTimeout(function(){     
					swal("<%= lst.size() %> Industries Presented within <%= userState%>");}, 200); 
				$("#radardetailid").show();
			});
	}
	
	function showDetailsForClient(paraStr){
		swal("MDCP Client Identifier", paraStr, "success");
	}

	function userlocationsave(obj){
		swal(
				{
					title: "Dear <%= wcu.getNickname()%>!",   
					text: "Drop you city name",   
					type: "input",   
					showCancelButton: true,   
					closeOnConfirm: false,   
					animation: "slide-from-top",   
					inputPlaceholder: "<%= addressInfo.get(0)%> | <%= addressInfo.get(1)%> | <%= addressInfo.get(2)%> | <%= addressInfo.get(3)%> | <%= addressInfo.get(4)%>" 
				}, 
				function(inputValue){
					inputVar = inputValue;
					if (inputValue === false) return false;      
					if (inputValue === "") {     
						swal.showInputError("You need to write something!");     
						return false;   
					}
					$.ajax(
						{
							type:"get",
							url:"http://shenan.duapp.com/InsertCommentsFromVisitor?OpenID=sadjasdhasjdasdasasd&comments="+inputValue,
							data:"",
							success:function(data){}
						}		
					)
					.done(function(data){
						swal("Thank You!", "your location saved", "success");
					})
					.error(function(data)
					{
						swal("Oops", "please try again later!", "error");
					}		
					);
					 
				}
			);
	}
	</script>

</head>
<body>
	<div class="loader more" id="goaway"></div>
	<div class="demo-content">
		<img class="mes-openbt" data-mesid="message-5" style="width:150px;height:58px;" src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=015900000053FQo&oid=00D90000000pkXM&lastMod=1438220916000" alt="HP Logo"/> 
	</div>

<div id="userInfo">
	<p class="navbar-text pull-right">Welcome <a href="http://shenan.duapp.com/mdm/profile.jsp?UID=<%= uid%>" class="navbar-link"><%= userName %></a><br />
		<a href="http://shenan.duapp.com/mdm/profile.jsp?UID=<%= uid%>"><img src="<%= userImage %>" alt="userImage" class="userImage pull-right"/></a>
		<img id="user_location_save" onclick="javascript:userlocationsave(this);" src="../MetroStyleFiles/setuplocation.png" alt="userImage" class="userImage pull-right" style="position:relative;top:260px;right:-30%; z-index: 8;"/>
	</p>

</div>

 <div id="topinfo">
		<svg id="fillgauge4" width="0%" height="0" onclick="gauge4.update(NewValue());"></svg>
		<svg id="fillgauge5" width="50%" height="220" onclick="Javascript:OrganizationInformation();"></svg>
		<script>
		var percent ="0.66";
		var percent2 = 100*percent;
		  var gauge4 = loadLiquidFillGauge("fillgauge4", 50);
		    var config4 = liquidFillGaugeDefaultSettings();
		    config4.circleThickness = 0.15;
		   config4.circleColor = "#FFFFFF";
		    config4.textColor = "#00b287";
		    config4.waveTextColor = "#00b287";
		    config4.waveColor = "#00b287";
		    config4.textVertPosition = 0.8;
		    config4.waveAnimateTime = 1000;
		    config4.waveHeight = 0.05;
		    config4.waveAnimate = true;
		    config4.waveRise = false;
		    config4.waveHeightScaling = false;
		    config4.waveOffset = 0.25;
		    config4.textSize = 0.75;
		    config4.waveCount = 3;
		  var gauge5 = loadLiquidFillGauge("fillgauge5", percent2 , config4);
		    var config5 = liquidFillGaugeDefaultSettings();
		    config5.circleThickness = 0.4;
		    config5.circleColor = "#FFFFFF";
		    config5.textColor = "#00b287";
		    config5.waveTextColor = "#00b287";
		    config5.waveColor = "#00b287";
		    config5.textVertPosition = 0.52;
		    config5.waveAnimateTime = 5000;
		    config5.waveHeight = 0;
		    config5.waveAnimate = false;
		    config4.waveRise = true;
		    config5.waveCount = 2;
		    config5.waveOffset = 0.25;
		    config5.textSize = 1.2;
		    config5.minValue = 30;
		    config5.maxValue = 150;
		    config5.displayPercent = false;
		    function NewValue(){
		        return 100*0.68;
		    }
		</script>
 </div>


    
<section id="mainform">
 
	<!-- START METROTAB -->
    <div class="metrotabs" >
        <div class="mt-blocksholder floatleft masonry" style="width: 100%; display: block; position: relative; height: 100%;" >
            <div id="tileboxjs" class="tile-bt-long img-purtywood mt-tab mt-active mt-loadcontent masonry-brick" style="position: absolute; top: 0px; left: 0px;">
                <a href="javascript:void(0);">
	                <img src="../MetroStyleFiles/datalake.png" alt="">
	                <span class="light-text"><strong>Data Lake</strong></span>
                </a>
            </div>
			
			<div id="openmes" class="tile-bt-long solid-green-2 mt-tab mt-loadcontent masonry-brick" style="position: absolute; top: 0px; left: 100px;">
                <a href="javascript:void(0);">
	                <img src="../MetroStyleFiles/person.png" alt="">
	                <span class="light-text">Show Case</span>
                </a>
            </div>
            
            <div id="capuqino" data-ext="html" onclick="javascript:loadChart5(this);" class="tile-bt-long solid-orange-2 mt-tab mt-loadcontent masonry-brick" style="position: absolute; top: 200px; left: 0px;">
                <a href="javascript:void(0);">
	                <img src="../MetroStyleFiles/image/icon.png" alt="">
	                <span class="light-text">卡布奇诺</span>
                </a>
            </div>
            
			<div id="openfooter" onclick="javascript:loadChart(this);" class="tile-bt-long img-wildoliva mt-tab mt-loadcontent masonry-brick" style="position: absolute; top: 300px; left: 0px;">
                <a href="javascript:void(0);">
	                <img src="../MetroStyleFiles/visualview.png" alt="">
	                <span class="light-text">Business Type</span>
                </a>
            </div>
            
            <div id="conporlan" onclick="javascript:loadChart4(this);" class="tile-bt solid-red mt-tab mt-loadcontent masonry-brick" style="position: absolute; top: 200px; left: 200px;">
                <a href="javascript:void(0);" target="_blank">
					<img src="../MetroStyleFiles/image/icon.png" alt="">
					<span class="light-text">康宝蓝</span>
                </a>
            </div>
			
			<div id="espresso" onclick="javascript:loadChart2(this);" class="tile-bt solid-blue-2 mt-tab mt-loadcontent masonry-brick" style="position: absolute; top: 300px; left: 200px;">
                <a href="javascript:void(0);">
	                <img src="../MetroStyleFiles/location.png" alt="">
	                <span class="light-text">Geolocation</span>
                </a>
            </div>

			
			<div id="americano" onclick="javascript:loadChartRadar(this);" class="tile-bt-long solid-red-2 mt-tab mt-loadcontent masonry-brick" style="position: absolute; top: 400px; left: 0px;">
                <a href="javascript:void(0);">
	                <img src="../MetroStyleFiles/industry.png" alt="">
	                <span class="light-text">Industry</span>
                </a>
            </div>
            
            <div id="joinus" class="tile-bt-long solid-red-2 mt-tab  masonry-brick" style="position: absolute; top: 400px; left: 0px;">
		        <div class="tile-bt-long solid-green hovershadow-green">
		            <a href="javascript:void(0);" onClick="Javascript:CommentMe();"  title="move together">
		                <img src="../MetroStyleFiles/image/documents.png" alt="MetroTab Docs">
		                <span class="light-text" style="margin-left:5px; font-size:20px;">Join US</span>
		            </a>
		        </div>
    		</div>

        <div class="clearspace"></div>
        
        </div>
        
<!-- START CONTENT -->
        <div class="mt-contentblock  floatleft" style="padding: 5px; height: 100%; width:100%; display: block;">
	        <div class="mt-content jspScrollable" style="height: 100%; top: 0px; overflow: hidden; padding: 0px; width: 100%;" tabindex="0">
				<div class="jspContainer" style="width: 100%; height: 100%;">
					<div class="jspPane" style="padding: 0px; top: 0px; width: 100%;">
						<div>
							<h3><a href="http://shenan.duapp.com/mdm/DQNavigate.jsp?UID=<%= uid%>" target="_blank" class="dark-text">Master Data Lake</a></h3>
							<p>
								<a href="http://shenan.duapp.com/mdm/DQNavigate.jsp?UID=<%= uid%>" target="_blank" class="resimg"><img class="imagesize" src="../MetroStyleFiles/image/datalakedashboard.jpg" alt="TileBox jQuery"></a>
							</p>
							<p>
								 If you think of a datamart as a store of bottled water – cleansed and packaged and structured for easy consumption – the data lake is a large body of water in a more natural state. The contents of the data lake stream in from a source to fill the lake, and various users of the lake can come to examine, dive in, or take samples
						  		 <br /> --Pentaho CTO James Dixon
						  	</p>    
							<div class="readmore">
								<a href="http://shenan.duapp.com/mdm/DQNavigate.jsp?UID=<%= uid%>" target="_blank" class="demoitem solid-blue-2 light-text floatleft">READ MORE</a>
								<div class="clearspace"></div>
							</div>
						</div>
					</div>
					<div class="jspVerticalBar">
						<div class="jspCap jspCapTop"></div>
						<div class="jspTrack" style="height: 100%;">
							<div class="jspDrag" style="height: 100%;">
								<div class="jspDragTop"></div>
								<div class="jspDragBottom"></div>
							</div>
						</div>
						<div class="jspCap jspCapBottom"></div>
					</div>
					</div>
			</div>
		</div>
<!-- END CONTENT -->
    </div><div class="clearspace"></div>
	<!-- END METROTAB -->
</section>

 
<div id="chart3">
		<script>
			var chart = c3.generate({
						data : {
							columns : [ 
									        [ 'Customer',60],
											[ 'Partner', 30],
											[ 'Competitor', 5],
											[ 'Lead', 5] 
						    		  ],
							type : 'pie'
						},
						pie : {
							label : {
								format : function(value, ratio, id) {
									return d3.format('#')(value);
								}
							}
						},
						bindto : '#chart3'
					});
			$("#chart3").hide();
		</script>
</div>
<div id="chart2">
 	<script>
	    <% 
	    	List<String> listOfCities = RestUtils.CallGetFilterNonLatinCityFromMongo(userState);
	    	String a = "['客户'";
	    	String b = "['竞争'";
	    	String c = "['伙伴'";
	    	String d = "";
	    	int countOfCity = 0;
	    	if(listOfCities.size() <= 10){
	    		countOfCity = listOfCities.size();
	    	}
	    	else{
	    		countOfCity = 10;
	    	}
	    	for(int i = 0; i < countOfCity ; i ++){
	    		 MdmDataQualityView mqvByStateCity = RestUtils.callGetDataQualityReportByParameter(userState,listOfCities.get(i),"");
	    		 a = a + "," + mqvByStateCity.getNumberOfCustomer();
	    		 b = b + "," + mqvByStateCity.getNumberOfCompetitor();
	    		 c = c + "," + mqvByStateCity.getNumberOfPartner();
	    		 d = d + "'"+ listOfCities.get(i) +"',";
	    	}
	    	a = a + "]";
	    	b = b + "]";
	    	c = c + "]";
	    	d = d.substring(0, d.length()-1);
	    	d = d + "";
	    %>
	    
		var chart = c3.generate({
			data: {
				columns: [
				          <%= a%>,
				          <%= b%>,
				          <%= c%>
				         ]
			},
			axis: {
				x: {
					type: 'category',
					categories: [<%= d%>]
				}
			},
			zoom: {
		        enabled: true
		    },
		    bindto : '#chart2'
		});
		$("#chart2").hide(); 
	</script>
 </div>
 <div id="chart3Radar" onclick="javascript:loadChartRadarWithDetail(this);">
	 <script>
		var w = 250, h = 250;
		var colorscale = d3.scale.category10();
		//Legend titles
		var LegendOptions = ['A','B'];
		//Data
<%--    		<% 
			String Ret = "";
			List<String> listOfSegmentArea = RestUtils.CallGetJSFirstSegmentAreaFromMongo("200000", userState);
            double m = Double.valueOf("200000");
			String RetStr = "";
			int upcnt = listOfSegmentArea.size();
			if(upcnt >= 10){
				upcnt = 10;
			}
 			for (int i = 0; i < upcnt; i++) {
				double num;
				double n = Double.valueOf(RestUtils.CallgetFilterCountOnCriteriaFromMongo(listOfSegmentArea.get(i).trim(),"",userState,""));

				num = n/m;
				RetStr = RetStr + "{axis:\" " + listOfSegmentArea.get(i) + " \",value:" + num + "},";
			}
 			Ret = Ret + "[[" + RetStr.substring(0, RetStr.length() - 1) + "]]"; 
		%>
		 var d = <%= Ret%>; --%>
		 
		 
 		var d = [[{axis:" Automotive ",value:3.6345},{axis:" Business Services ",value:15.367},{axis:" Discrete - Machinery ",value:3.359},{axis:" Consumer Packaged Goods ",value:6.2055},{axis:" Construction ",value:3.1815},{axis:" Education: K-12 /School ",value:6.0675},{axis:" Wholesale Trade ",value:16.3635},{axis:" Retail ",value:10.1795},{axis:" Transportation&Trans Services ",value:3.1595},{axis:" Amusement and Recreation ",value:1.817}]];

		var mycfg = {
		  w: w,
		  h: h,
		  maxValue: 0.6,
		  levels: 6,
		  ExtraWidthX: 170
		};
		//Call function to draw the Radar chart
		//Will expect that data is in %'s
		RadarChart.draw("#chart3Radar", d, mycfg);

		var svg = d3.select('#americano_loadChart')
			.selectAll('svg')
			.append('svg')
			.attr("width", w+10)
			.attr("height", h);

		//Initiate Legend	
		var legend = svg.append("g")
			.attr("class", "legend")
			.attr("height", 100)
			.attr("width", 150)
			.attr('transform', 'translate(-220,40)') ;
			//Create colour squares
			legend.selectAll('rect')
			  .data(LegendOptions)
			  .enter()
			  .append("rect")
			  .attr("x", w - 65)
			  .attr("y", function(d, i){ return i * 20;})
			  .attr("width", 10)
			  .attr("height", 10)
			  .style("fill", function(d, i){ return colorscale(i);})
			  ;
			//Create text next to squares
			legend.selectAll('text')
			  .data(LegendOptions)
			  .enter()
			  .append("text")
			  .attr("x", w - 52)
			  .attr("y", function(d, i){ return i * 20 + 9;})
			  .attr("font-size", "11px")
			  .attr("fill", "#737373")
			  .text(function(d) { return d; });	
			$("#chart3Radar").hide();
	 </script>
 </div>

 <div id="chart4" >
		<script>
			var chart = c3.generate({
			    data: {
			        columns: [
			            ['data1', 30, 200, 100, 400, 150, 250, 50, 100, 250]
			        ]
			    },
			    axis: {
			        x: {
			            type: 'category',
			            categories: ['cat1', 'cat2', 'cat3', 'cat4', 'cat5', 'cat6', 'cat7', 'cat8', 'cat9']
			        }
			    },
			    bindto : '#chart4'
			});
 			$("#chart4").hide();
		</script>
	</div>
	
	<div id="chart5">
	<svg class="chart"></svg>
	
	<script>
		var data = {
		  labels: [
		    'resilience', 'maintainability', 'accessibility',
		    'uptime', 'functionality', 'impact'
		  ],
		  series: [
		    {
		      label: 'Customer',
		      values: [4, 8, 15, 16, 23, 42]
		    },
		    {
		      label: 'Partner',
		      values: [12, 43, 22, 11, 73, 25]
		    },
		    {
		      label: 'Competitor',
		      values: [31, 28, 14, 8, 15, 21]
		    },]
		};
		
		var chartWidth       = 200,
		    barHeight        = 15,
		    groupHeight      = barHeight * data.series.length,
		    gapBetweenGroups = 10,
		    spaceForLabels   = 100,
		    spaceForLegend   = 100;
		
		// Zip the series data together (first values, second values, etc.)
		var zippedData = [];
		for (var i=0; i<data.labels.length; i++) {
		  for (var j=0; j<data.series.length; j++) {
		    zippedData.push(data.series[j].values[i]);
		  }
		}
		
		// Color scale
		var color = d3.scale.category20();
		var chartHeight = barHeight * zippedData.length + gapBetweenGroups * data.labels.length;
		
		var x = d3.scale.linear()
		    .domain([0, d3.max(zippedData)])
		    .range([0, chartWidth]);
		
		var y = d3.scale.linear()
		    .range([chartHeight + gapBetweenGroups, 0]);
		
		var yAxis = d3.svg.axis()
		    .scale(y)
		    .tickFormat('')
		    .tickSize(0)
		    .orient("left");
		
		// Specify the chart area and dimensions
		var chart = d3.select(".chart")
		    .attr("width", spaceForLabels + chartWidth + spaceForLegend)
		    .attr("height", chartHeight);
		
		// Create bars
		var bar = chart.selectAll("g")
		    .data(zippedData)
		    .enter().append("g")
		    .attr("transform", function(d, i) {
		      return "translate(" + spaceForLabels + "," + (i * barHeight + gapBetweenGroups * (0.5 + Math.floor(i/data.series.length))) + ")";
		    });
		
		// Create rectangles of the correct width
		bar.append("rect")
		    .attr("fill", function(d,i) { return color(i % data.series.length); })
		    .attr("class", "bar")
		    .attr("width", x)
		    .attr("height", barHeight - 1);
		
		// Add text label in bar
		bar.append("text")
		    .attr("x", function(d) { return x(d) - 3; })
		    .attr("y", barHeight / 2)
		    .attr("fill", "red")
		    .attr("dy", ".35em")
		    .text(function(d) { return d; });
		
		// Draw labels
		bar.append("text")
		    .attr("class", "label")
		    .attr("x", function(d) { return - 10; })
		    .attr("y", groupHeight / 2)
		    .attr("dy", ".35em")
		    .text(function(d,i) {
		      if (i % data.series.length === 0)
		        return data.labels[Math.floor(i/data.series.length)];
		      else
		        return ""});
		
		chart.append("g")
		      .attr("class", "y axis")
		      .attr("transform", "translate(" + spaceForLabels + ", " + -gapBetweenGroups/2 + ")")
		      .call(yAxis);
		
		// Draw legend
		var legendRectSize = 18,
		    legendSpacing  = 4;
		
		var legend = chart.selectAll('.legend')
		    .data(data.series)
		    .enter()
		    .append('g')
		    .attr('transform', function (d, i) {
		        var height = legendRectSize + legendSpacing;
		        var offset = -gapBetweenGroups/2;
		        var horz = spaceForLabels + chartWidth + 40 - legendRectSize;
		        var vert = i * height - offset;
		        return 'translate(' + horz + ',' + vert + ')';
		    });
		
		legend.append('rect')
		    .attr('width', legendRectSize)
		    .attr('height', legendRectSize)
		    .style('fill', function (d, i) { return color(i); })
		    .style('stroke', function (d, i) { return color(i); });
		
		legend.append('text')
		    .attr('class', 'legend')
		    .attr('x', legendRectSize + legendSpacing)
		    .attr('y', legendRectSize - legendSpacing)
		    .text(function (d) { return d.label; });
		
		$("#chart5").hide();
		</script>
	</div>
 <!-- -------------------------------------------------------------------------------------------------------------- -->
 <!-- -------------------------------------------------------------------------------------------------------------- -->
<div id="mt-station">

<!-- MetroTab Content 卡布奇诺-->
<div data-mtid="capuqino" id="capuqino_loadChart">

</div>
<!-- End MetroTab Content  卡布奇诺-->

<!-- MetroTab Content 美式咖啡 Industry-->
<div data-mtid="americano"> 
	<div id="americano_loadChart"></div>
	<div id="radardetailid">
<%--    		<%
			for(String i : lst){
				String cnt =  RestUtils.CallgetFilterCountOnCriteriaFromMongo(i,"","重庆","");
				i = i.replaceAll("\\s+","");
				i = i.replaceAll("-", "");
				double n = Double.valueOf(cnt);
				double m = Double.valueOf(totalcntwithRegion);
				double percent = n/m;
				String mywidth = percent*100 + "%";
				out.print("<div class=\"progress\"><div class=\"progress-bar progress-bar-success\" role=\"progressbar\" aria-valuenow=\""+ cnt +"\" aria-valuemin=\"0\" aria-valuemax=\""+ totalcntwithRegion +"\" style=\"width: "+ mywidth +";\"><span style=\"text-align:center; color:#000; \"> "+ i +" </span></div><span style=\"float:right;\">"+ cnt +"</span></div>");
			}
		%> --%>
</div>

</div>
<!-- End MetroTab Content  美式咖啡-->


<!-- MetroTab Content espresso浓缩-->
<div data-mtid="espresso" id="openfooter_loadC22"> 
	<div id="openfooter_loadC2"></div>
</div>
<!-- End MetroTab Content  espresso浓缩-->

<!-- Start MetroTab Content 康宝蓝-->
<div data-mtid="conporlan">
	<div >
		<div  style="position:relative; width:500px; height:500px;">
			<div id="conporlan_loadChart" style="position:absolute;"></div>
		</div>
	</div> 
	<!-- <div id="conporlan_loadChart"></div> -->
</div>
<!-- End MetroTab Content  康宝蓝-->

<!-- MetroTab Content 摩卡-->
<div data-mtid="openmes">
	<br />
	<ul class="nav nav-pills nav-stacked">
		<%
		List<ClientInformation> clientList = new ArrayList<ClientInformation>();
		clientList = RestUtils.CallGetClientFromMongoDB();
		String htmlcustli = "<div class=\"well well-sm\">"+clientList.size()+" Active Clients in service</div>";
		if(clientList.size()!= 0){
			for(ClientInformation ci : clientList){
				htmlcustli = htmlcustli + "<li class=\"active\"><a href=\"#\" onclick=\"javascript:showDetailsForClient('" + ci.getClientIdentifier() + "');\"><span class=\"badge pull-right\">" + ci.getClientID() + "</span>"+ ci.getClientDescription() +"</a></li>";
			}
		}
		%>
		
		<%= htmlcustli%>
	</ul>

</div>
<!-- End MetroTab Content 摩卡-->


<!-- Start MetroTab Content 玛琪雅朵-->
<div data-mtid="openfooter" id="openfooter_loadC33">
	<div id="openfooter_loadC3"></div>
</div>
<!-- End MetroTab Content 玛琪雅朵-->


<!-- Start MetroTab Content 拿铁-->
<div data-mtid="tileboxjs">
	<div>
			<p>
				<a href="http://shenan.duapp.com/mdm/DQNavigate.jsp?UID=<%= uid%>"
					target="_blank" class="resimg"><img class="imagesize"
					src="../MetroStyleFiles/image/datalakedashboard.jpg"
					alt="TileBox jQuery"></a>
			</p>
			<p>
				If you think of a datamart as a store of bottled water – cleansed
				and packaged and structured for easy consumption – the data lake is
				a large body of water in a more natural state. The contents of the
				data lake stream in from a source to fill the lake, and various
				users of the lake can come to examine, dive in, or take samples <br />
				--Pentaho CTO James Dixon
			</p>
			<div class="readmore">
				<a href="http://shenan.duapp.com/mdm/DQNavigate.jsp?UID=<%= uid%>" target="_blank" class="demoitem solid-blue-2 light-text floatleft">READ MORE</a>
				<div class="clearspace"></div>
			</div>

		</div>
</div>
<!-- End MetroTab Content 拿铁-->
</div>




<!-- START MESSAGE STATION -->
	<div id="mes-station">
		<div class="mes-container item-profileview transparent-black"
			data-mesid="message-5">
			<!-- Start Content Holder -->
			<div class="mes-contentholder">
				<div class="item-profilebody">
					<!-- Start Background -->
					<div class="mes-content item-profilebg solid-smoke"
						data-show="hmove" data-start="-100" data-showdura="400"></div>
					<!-- End Background -->

					<!-- Start Control Bar -->
					<div class="mes-content item-ctrlbar-5" data-show="fade"
						data-showdura="200">
						<div class="mes-closebt light-text floatleft">
							<img src="../MetroStyleFiles/exit.png"
								style="width: 40px; height: 40px;" />
						</div>
						<div class="clearspace"></div>
					</div>
					<!-- End Control Bar -->

					<!-- Start Header Photo -->
					<div class="mes-content item-headerphoto" data-show="bounceInDown">
						<img style="width: 100%; height: 200px;"
							src="../MetroStyleFiles/reallake.jpg" alt="demo-headphoto">
					</div>
					<!-- End Header Photo -->

					<!-- Start Social Connection -->
					<div class="mes-content item-pfconnect" data-show="hmove"
						data-start="-100" data-showdura="400">
						<div class="social-badges">
							<i class="fa fa-facebook-square"></i>
							<i class="fa fa-google-plus-square"></i>
							<i class="fa fa-twitter-square"></i>
						</div>
					</div>
					<!-- End Social Connection -->
					<img  src="../MetroStyleFiles/image/datalakepure.jpg" alt="demo-headphoto">
					<!-- Start Info -->
					<div  data-show="fadeInDown">
						<img  src="../MetroStyleFiles/image/sitemaintenance_robot_animation.gif" alt="demo-headphoto">a
						<img  src="../MetroStyleFiles/image/datalakepure.jpg" alt="demo-headphoto">
					</div>

				</div>
				<img  src="../MetroStyleFiles/image/sitemaintenance_robot_animation.gif" alt="demo-headphoto">
			</div>
		</div>
		<!-- End Content Holder -->
	</div>
	
	
	
	
<!--  <div id="chart6" >
		<script>
			var chart = c3.generate({
			    data: {
			        columns: [
			            ['data1', 30, 200, 100, 400, 150, 250, 50, 100, 250]
			        ]
			    },
			    axis: {
			        x: {
			            type: 'category',
			            categories: ['cat1', 'cat2', 'cat3', 'cat4', 'cat5', 'cat6', 'cat7', 'cat8', 'cat9']
			        }
			    },
			    bindto : '#chart6'
			});
			$("#chart6").hide();
		</script>
</div> -->
<!-- END MESSAGE STATION -->


<div class="panel-footer"><span>©</span> 2016 Hewlett-Packard Enterprise Development Company, L.P.</div>

</body></html>