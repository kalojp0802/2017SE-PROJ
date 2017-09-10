<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.GameData"%>
<%@ page import="model.Item"%>
<%@ page import="java.util.List"%>
<!DOCTYPE HTML>
<html>
<head>
<%
	String path = request.getContextPath();
	GameData gamedata = (GameData)session.getAttribute("gamedata");
	if(gamedata == null){
		response.sendRedirect("login_again");
	}
	
	List<Integer> have_items = (List<Integer>)request.getAttribute("have_items");
	List<Item> characteritems = (List<Item>)request.getAttribute("characteritems");
	String username = (String)session.getAttribute("username");
	Integer single_winrate=0;
	if(gamedata.getSinglegame()!=0)
		single_winrate = (Integer)(gamedata.getSinglewin()*100/gamedata.getSinglegame());
	Integer rank_winrate=0;
	if(gamedata.getRankgame()!=0)
		rank_winrate=(Integer)(gamedata.getRankwin()*100/gamedata.getRankgame());
	Integer team_winrate=0;
	if(gamedata.getTeamgame()!=0)
		team_winrate=(Integer)(gamedata.getTeamwin()*100/gamedata.getTeamgame());
%>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>GameMain-Let's start your game</title>
<link href="<%=path%>/summerproject/css/GameMain/bootstrap.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/summerproject/css/GameMain/bootstrap-responsive.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=path%>/summerproject/css/GameMain/style.css">

<link href="<%=path%>/summerproject/css/GameMain/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/summerproject/css/GameMain/prettyPhoto.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/modernizr.custom.js"></script>
</head>

<body>


<!--Start Slide 5-->

<div class="scroll-slide" id="slide5" data-move="4" data-stellar-background-ratio="0">
  <div class="slide5-separator"></div>
  <div class="slidename">单人模式</div>
 
  <div class="container">
    <div class="row">
      <div class="span12">
        <div class="dropcap">D</div>
        <p class="lead">请选择一个角色进行单人游戏 </p>
        <div class="col-xs-6">
					<select class="difficulty" id="difficulty">
						<option value="1" selected>难度1</option>
						<option value="2">难度2</option>
						<option value="3">难度3</option>
					</select>
				</div>
      </div>
     
      
      <%
      for(int x = 0;x < characteritems.size();x++){
    	  if(have_items.get(x)==1){
    	  %>
    	   <div class="span3">
          <div class="photographer">
             <div class="photo-frame-1">
             <img src="<%=path%>/summerproject/images/character/<%=(String)characteritems.get(x).getPath() %>" alt="Two" onclick="getInfo(<%=characteritems.get(x).getCharacterid()%>)"/></div>
          <h3><%=(String)characteritems.get(x).getDescription() %></h3>
          <div class="skill">速度</div>
            <div class="progress progress-danger progress-striped active">
              <div class="bar" data-percentage="<%=(int)(characteritems.get(x).getSpeed()/20)%>"></div>
            </div>
            <div class="skill">攻击力</div>
            <div class="progress progress-danger progress-striped active">
              <div class="bar" data-percentage="50"></div>
            </div>
        </div>
      </div>
    	  
    	  <%
    	  }
      }
      %>
      

      <div class="span12">
        <div class="fancy-heading-big">
          <h3>Fun Facts</h3>
        </div>
        <div class="fun-facts">
          <div class="fun-fact">
            <div class="fun-fact-digit"><%=gamedata.getSinglegame() %></div>
            <div class="fun-fact-text">单人模式场次</div>
          </div>
          <div class="fun-fact">
            <div class="fun-fact-digit"><%=single_winrate %>%</div>
            <div class="fun-fact-text">单人模式胜率</div>
          </div>
          <div class="fun-fact">
            <div class="fun-fact-digit"><%=gamedata.getRankgame() %></div>
            <div class="fun-fact-text">排位模式场次</div>
          </div>
          <div class="fun-fact">
            <div class="fun-fact-digit"><%=rank_winrate %>%</div>
            <div class="fun-fact-text">排位模式胜率</div>
          </div>
          <div class="fun-fact">
            <div class="fun-fact-digit"><%=gamedata.getTeamgame() %></div>
            <div class="fun-fact-text">组队模式场次</div>
          </div>
          <div class="fun-fact">
            <div class="fun-fact-digit"><%=team_winrate %>%</div>
            <div class="fun-fact-text">组队模式胜率</div>
          </div>
        </div>
        <div class="fancy-heading-big">
          <h5><a href="returnhome" >返回主界面</a></h5>
        </div>
      </div>
      
      
      
    </div>
  </div>
</div>
<!--End Slide 5--> 


<!-- Footer -->
<div class="scroll-slide" id="slide4" data-move="5" data-stellar-background-ratio="0.5">
<footer class="footer">
  <div class="container">
  
    <div class="row"> 
      <!--Address and Company Name-->
      <div class="span4">
        <h4>Quick Info</h4>
        <p>Summer Project</p>
        <br/>
        <p>王雨乐</p>
        <br/>
        <p>彭浩伦</p>
        <br/>
        <p>高仓靖博</p>
      </div>
     </div>
     
     	<h5><a href="logout" >退出登录</a></h5>
    </div>
    </footer>
  </div>


<!-- Footer Ends --> 

<script>
	function getInfo(id){
		var difficulty = document.getElementById("difficulty").value;
		jsPost('set_choice',{'difficulty' : difficulty , 'character' : id});
	}
	var jsPost = function(action, values) {
		  var id = Math.random();
		  document.write('<form id="post' + id + '" name="post'+ id +'" action="' + action + '" method="post">');
		  for (var key in values) {
		    document.write('<input type="hidden" name="' + key + '" value="' + values[key] + '" />');
		  }
		  document.write('</form>');  
		  document.getElementById('post' + id).submit();
		}

</script>

<!--Scripts--> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.cbpQTRotator.min.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/bootstrap.min.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.prettyPhoto.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/js.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.isotope.min.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.masonry.min.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.stellar.min.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/waypoints.min.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.easing.1.3.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.jigowatt.js"></script> 
<script type="text/javascript" src="<%=path%>/summerproject/js/GameMain/jquery.nicescroll.min.js"></script>
</body>
</html>