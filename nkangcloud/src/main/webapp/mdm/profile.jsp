<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ page import="java.util.*" %>
<%@ page import="com.nkang.kxmoment.baseobject.MdmDataQualityView" %> 
<%@ page import="com.nkang.kxmoment.baseobject.GeoLocation" %> 
<%-- <%@ page import="com.nkang.kxmoment.util.DBUtils"%> --%>
<%@ page import="com.nkang.kxmoment.util.RestUtils"%>
<%@ page import="com.nkang.kxmoment.baseobject.WeChatUser"%>
<%					

MdmDataQualityView mqv = new MdmDataQualityView();
//mqv= DBUtils.getDataQualityReport();
mqv= RestUtils.callGetDataQualityReport();
//String AccessKey = DBUtils.getValidAccessKey();
String AccessKey =RestUtils.callGetValidAccessKey();
String uid = request.getParameter("UID"); 
//GeoLocation loc = DBUtils.getDBUserGeoInfo(uid);
GeoLocation loc = RestUtils.callGetDBUserGeoInfo(uid);
WeChatUser wcu = RestUtils.getWeChatUserInfo(AccessKey, uid);
String curLoc = RestUtils.getUserCurLocWithLatLng(loc.getLAT() , loc.getLNG()); 
%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
  <head>
	<meta charset="utf-8" />
	<title>HPE - Master Data Management</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="hpe" />

	<link href="../nkang/assets_athena/bootstrap/css/bootstrap.min.css" 				rel="stylesheet" type="text/css"/>
	<link href="../nkang/assets_athena/bootstrap/css/bootstrap-responsive.min.css" 	rel="stylesheet" type="text/css"/>
	<link href="../nkang/assets_athena/font-awesome/css/font-awesome.css" 			rel="stylesheet" type="text/css"/>
	<link href="../nkang/css_athena/style.css" 										rel="stylesheet" type="text/css"/>
	<link href="../nkang/assets_athena/icomoon/iconMoon.css" 						rel="stylesheet" type="text/css"/>
	<link href="../nkang/css_athena/style-responsive.css" 							rel="stylesheet" type="text/css"/>
	<link href="../nkang/css_athena/style-default.css" 								rel="stylesheet" type="text/css"/>
	<link href="../nkang/assets_athena/data-tables/DT_bootstrap.css" 				rel="stylesheet" type="text/css"/>
	<script src="../nkang/js_athena/jquery-1.8.3.min.js"></script>
	<script src="../nkang/assets_athena/bootstrap/js/bootstrap.js"></script>
	<script src="../nkang/assets_athena/jquery-ui/jQuery_UI_1_10_3.js"></script>
	<script src="../nkang/js_athena/typeahead.js"></script>
	<script src="../nkang/js_athena/jquery.feedback_me.js"></script>
	<script src="../nkang/assets_athena/raty/ratyViewJs.js"></script>
	<script src="../nkang/assets_athena/data-tables/jquery.dataTables.js"></script>
	<script src="../nkang/assets_athena/data-tables/DT_bootstrap.js"></script>
	<script src="../nkang/js_athena/common-scripts.js"></script>

<style>
	.HpLogo{
	width:200px;
	height:60px;
	}

	#navlist li
	{
	display: inline;
	list-style-type: none;
	padding-right: 30px;
	white-space: nowrap;
	}
	.mainTitle{
	font-size:15px;
	}

	.loading {
	display: none;
	opacity: 0.7;
	filter:alpha(opacity=70); 
	position: absolute;
	left: 0;
	top: 0;
	width: 1000px;
	height: 100%;
	background-color: #FFFFFF;
	z-index: 1000;
	}


	.myButtons{
	background: none  !important;
	border: 0px  !important;
	background-color: #007DBA  !important;
	color: #fff !important;
	font-size: 13px  !important;
	border-radius: 0px  !important;
	padding: 6px 6px 6px 6px  !important;
	border-bottom-left-radius: 6px  !important;
	border-top-right-radius: 6px  !important;

	}
	.myButtons:hover{
	background-color: #D7410B !important;
	}
	.myDisabledButtons{
	background: none  !important;
	border: 0px  !important;
	background-color: gray !important;
	color: #fff !important;
	font-size: 13px  !important;
	border-radius: 0px  !important;
	padding: 6px 6px 6px 6px  !important;
	border-bottom-left-radius: 6px  !important;
	border-top-right-radius: 6px  !important;
	}
	.parentDisable{
	overflow:hidden;
	width:100%;
	//height:550px;
	clear: both;
	}



	/* upload button */
	::-webkit-file-upload-button {
	background: none;
	border: 0px;
	background-color: #007DBA;
	color: #fff !important;
	font-size: 14px;
	border-radius: 0px;
	padding: 8px 8px 8px 8px;
	border-bottom-left-radius: 6px;
	border-top-right-radius: 6px;
	}

	.linkBtn {
	background: none !important;
	border: 0px !important;
	background-color: #007DBA !important;
	color: #fff !important;
	font-size: 14px !important;
	border-radius: 0px !important;
	padding: 8px 8px 8px 8px !important;
	border-bottom-left-radius: 6px !important;
	border-top-right-radius: 6px !important;
	}
	.clear{clear:both}
	#positionToggle{position:absolute; top:9px; left:9px; }
	#showHideList{display:none; position:absolute; top:10px; left:10px; border-radius: 5px; border:1px solid #cccccc; background-color:#eeeeee; }
	#ListInner{padding:10px 10px 10px 10px; }

	.clearfix {
	*zoom: 1;
	}

	.clearfix:before, .clearfix:after {
	display: table;
	line-height: 0;
	content: "";
	}

	.clearfix:after {
	clear: both;
	}

	/*label,select,.ui-select-menu { float: left; margin-right: 10px; }
	.wrap ul.ui-selectmenu-menu-popup li a { font-weight: bold; }*/
	.ui-selectmenu{
	height: 1.5em;
	}
	.ui-selectmenu-status {
	line-height: 1.0em;
	}
</style>
<script>
      $j = jQuery.noConflict();
      function myAlter(err) {
          $('#myAlterMessage').html(err);
          $('#DivMyAlter').modal('show');
      }
      function myConfirm(msg,actionId) {
          $('#myConfirmMessage').html(msg);
          $('#DivMyConfirm').modal('show');
          $('#myConfirmSubmit').unbind();
          $('#myConfirmSubmit').click(function(){
              $('#DivMyConfirm').hide();
              $('[id$='+actionId+']').click();
          });
      }
      function myConfirmWithParm(msg,actionId,parm){
          $('#myConfirmMessage').html(msg);
          $('#DivMyConfirm').modal('show');
          $('#myConfirmSubmit').unbind();
          $('#myConfirmSubmit').click(function(){
              $('#DivMyConfirm').hide();
              $('[id$='+actionId+']').each(function(k){
                  if($(this).text() == parm){
                      $(this).click();
                      return;
                  }
              });
          });
      }
      </script>
  </head>
  <body>

    <div class="navbar">
      <div class="navbar-inner">
        <div class="container-fluid">
			  <img src="https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=015900000053FQo&oid=00D90000000pkXM&lastMod=1438220916000" alt="HP Logo" class="HpLogo"/> 
              <ul class="nav pull-right top-menu">
                <li class="dropdown">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown"> Welcome <span class="username colorBlue"> <%= wcu.getNickname()%> </span> 
						<span><a style="float:right;" href="baidu.com"> <img src="<%= wcu.getHeadimgurl()%>" alt="userImage" class="userImage" alt="no_username"/></a></span> 
                  	</a>
                </li>
              </ul>
         </div>
        </div>
    </div>

  <!-- BEGIN CONTAINER -->
  <div id="container" class="row-fluid"> 
    <!-- BEGIN PAGE -->
    <div id="main-content">
      <div class="BDbg">
        <div class="BDheading">
          <div class="span8"> 
            <div id="divBoardName"  style="dispaly:none" title='LBName'></div>
            <h2> <span class="colorDarkBlue">Location:</span> <span style="float:right;margin-right:10px;" class="colorDarkBlue"> <%= curLoc%></span></h2>
          </div>
          <div class="span4 BoardFormbtn" ></div>
        </div>
        <div class="container-fluid">
          <div class="row-fluid mtop10">
            <div class="span8">
              <div class="PositionR">
                  <img src="https://pbs.twimg.com/media/CUBPE5fXIAE8k8a.png" class="BoardDetailImage"/>
                <div class="BoardTit">
                  <div class="span8">
                      <h4>Manage your Profile </h4>
                  </div>
                </div>
              </div>
            </div>

            <div class="span4">
              <div class="BDdetailHeight">
                  <div>
						<a class="" data-toggle="modal" href="#LBreadmore"> Read more </a> 
                  </div>
              </div>  

              <div id="LBreadmore" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true" data-backdrop="static">
                <div class="modal-header">
                  profile
                </div>
                <div class="modal-body readmoreHpop" style="white-space: pre-line;">
                    Manage your profile here
                </div>
                <div class="modal-footer">
                  <button class="btnAthena" data-dismiss="modal" aria-hidden="true">Cancel</button>
                </div>
              </div>
                
                
                
              <div id="TopicReadMore" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true" data-backdrop="static">
                <div class="modal-header">
                  <h3>Profile</h3>
                </div>
                <div class="modal-body">
                  <div id="Topic"></div>
                </div>
                <div class="modal-footer">
                  <button class="btnAthena" data-dismiss="modal" aria-hidden="true">Cancel</button>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
      <div class="container-fluid">
        <div class="row-fluid mtop20">
          <div class="span8">
            <div class="TABclass">
              <ul class="nav nav-tabs" id="myTabs">
                <li id="liSocialElements" class="active"><a href="#SocialElements" data-toggle="tab">Social Elements</a></li>
                <li id="liBoardContent" ><a href="#BoardContent" data-toggle="tab">Profile</a></li>
                <li id="liWorkMates"><a href="#WorkMates" data-toggle="tab">Work Mates</a></li>
              </ul>
              <div class="tab-content" id="dvTabContent">
                <div class="tab-pane" id="BoardContent">
                  <div>
                    <div class="panel-group" id="accordion">
                      <div id="DivLearnings">
                                <form>
                                        <table class="table">
                                            <tbody>
                                                  <tr>
                                                     <td class="text-right">
                                                        <span style="text-align:right;"><strong>Nick Name:</strong></span>
                                                     </td>
                                                    <td>
                                                        NKANG
                                                    </td> 
                                                  </tr>
                                                  <tr>
                                                     <td class="text-right">
                                                        <span style="text-align:right;"><strong>Legal Name:</strong></span>
                                                     </td>
                                                    <td>
                                                        NKANG
                                                    </td> 
                                                  </tr>
                                                  <tr>
                                                     <td class="text-right">
                                                        <span style="text-align:right;" ><strong>Email:</strong></span>
                                                     </td>
                                                    <td>
                                                        NKANG
                                                    </td> 
                                                  </tr>
                                                  <tr>
                                                     <td class="text-right">
                                                         <span style="text-align:right;"><strong>Project Manager:</strong></span>
                                                     </td>
                                                    <td>
                                                        NKANG
                                                    </td>
                                                  </tr>
                                                  <tr>
                                                    <td class="text-right">
                                                         <span style="text-align:right;"><strong>Project Lead:</strong></span>
                                                     </td>
                                                    <td>
                                                        NKANG
                                                    </td>  
                                                  </tr>
                                                  <tr >
                                                     <td class="text-right">
                                                        <span style="text-align:right;"><strong>Profile Photo:</strong></span>
                                                     </td>
                                                    <td>
														NKANG
													</td>
                                                  </tr>
                                             </tbody>
                                        </table>
										<input type = "button" value ="Save" class="myButtons" style="width:50%;float:right;"/>
                                </form>
                      </div>
                    </div>
                  </div>
                </div>
                  <div class="tab-pane active" id="SocialElements">
                      <div class="modal-header">
							Opportunities :<%= mqv.getNumberOfLeads() %>
                      </div>
                      <div class="modal-header">
							Competitors :<%= mqv.getNumberOfCompetitor() %>  
                      </div>
                      <div class="modal-body readmoreHpop" style="white-space: pre-line;">
                          <table class="table">
                              <tbody>
                                  <tr>
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Count Of Customer:</strong></span>
                                      </td>
                                      <td>
                                          <%= mqv.getNumberOfCustomer() %>
                                      </td>
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Count Of Partner:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel ><%= mqv.getNumberOfPartner() %></apex:outputLabel>
                                      </td> 
                                  </tr>
                                  <tr>
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Country:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!country}</apex:outputLabel>
                                      </td>
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>City:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!city}</apex:outputLabel>
                                      </td> 
                                  </tr>
                                  <tr>
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Sunrise:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!sunrise}</apex:outputLabel>
                                      </td> 
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Sunset:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!sunset}</apex:outputLabel>
                                      </td> 
                                  </tr>
                                  <tr>
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Pressure:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!pressure}</apex:outputLabel>
                                      </td> 
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Humidity:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!humidity}</apex:outputLabel>
                                      </td> 
                                  </tr>
                                  <tr>
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>rising:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!rising}</apex:outputLabel>
                                      </td> 
                                      <td class="text-right">
                                          <span style="text-align:right;"><strong>Visibility:</strong></span>
                                      </td>
                                      <td>
                                          <apex:outputLabel >{!visibility}</apex:outputLabel>
                                      </td> 
                                  </tr> 
                              </tbody>
                          </table>

                      </div>
                  </div>
                <div class="tab-pane" id="WorkMates">
                  <div>
                      <div > <!-- class="span4" -->
                          <div class="row-fluid">
                              <div class="hpit_athena_rightDiv span12">
                                  <div style="overflow: auto; width: auto; max-height:442px;">
                                      <span>My Work Mates</span>
                                      <ul class="item-list scroller padding" data-always-visible="1" id="navlist">
                                          <div id="divContMember">
                                              <apex:repeat value="{!MemberList}" var="m">
                                                  <li><apex:image url="{!IF(m.FormalHeadUrl__c == '', m.HeadUrl__c, m.FormalHeadUrl__c)}" styleClass="userImage" alt="no_username"/><span style="width:50px">{!IF(m.FormalName__c == '',m.UserNickName__c,m.FormalName__c)}</span></li>
                                              </apex:repeat>
                                          </div>
                                      </ul>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
            
            

            
            
        </div>
      </div>
    </div>
    <!-- END PAGE -->
      </div>
      
<!-- Modal PAGE Start-->   
      <div id="DivMyAlter" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
          <div class="modal-header">
            <h3>Error Message</h3>
          </div>
          <div class="modal-body">
            <div class="span5 ml0" id="myAlterMessage">
              
            </div>
          </div>
          <div class="modal-footer">
              <button class="btnAthena EbtnLess" data-dismiss="modal" aria-hidden="true">OK</button>
          </div>
    </div>
    <div id="DivMyConfirm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
          <div class="modal-header">
            <h3>Confirm Message</h3>
          </div>
          <div class="modal-body">
            <div class="span5 ml0" id="myConfirmMessage">
              
            </div>
          </div>
          <div class="modal-footer">
              <button class="btnAthena EbtnLess" data-dismiss="modal" aria-hidden="true">Cancel</button>
              <button class="btnAthena EbtnLess" id="myConfirmSubmit">Submit</button>
          </div>
    </div>
<!-- Modal PAGE End-->   

  <!-- BEGIN FOOTER -->
  <div id="footer"> <span>©</span> Hewlett-Packard Enterprise Development Company, L.P.   |   HP Restricted </div>
  <!-- END FOOTER --> 
  </body>
  </html>