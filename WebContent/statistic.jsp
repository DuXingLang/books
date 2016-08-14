<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.data.general.DefaultPieDataset" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
<%@ page import="org.jfree.chart.plot.PlotOrientation" %>
<%@ page import="org.jfree.chart.entity.StandardEntityCollection" %>
<%@ page import="org.jfree.chart.ChartRenderingInfo" %>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@ page import="org.jfree.chart.StandardChartTheme"%>
<%@ page import="java.awt.Font"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List" %>
<%@ page import="valuebean.SaleSingle" %>
<%@ page import="valuebean.StatisticSingle" %>
<%@ page import="toolbean.MyTools"%>
<%@ page import="toolbean.Connectdb"%>
<%
  float numAll=0;
  String sql="select type_table.typeName,sum(sales) as salesTotal from sales_table,type_table "+
  "where sales_table.bookType=type_table.bookType group by sales_table.bookType";
  Connectdb connection = new Connectdb();
  ResultSet rs = connection.executeQuery(sql);//执行SQL语句并取得结果集
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>图表显示销售结果</title>
	<link style="text/css" rel="stylesheet" href="css/statistic.css"/>
    <script type="text/javascript">
         
    // JS实现选项卡切换
        window.onload = function(){
             var oTab = document.getElementById("tabs");
             var oUl = oTab.getElementsByTagName("ul")[0];
             var oLis = oUl.getElementsByTagName("li");
             var oDivs= oTab.getElementsByTagName("div");

             for(var i= 0,len = oLis.length;i<len;i++){
                 oLis[i].index = i;
                 oLis[i].onclick = function() {
                     for(var n= 0;n<len;n++){
                         oLis[n].className = "";
                         oDivs[n].className = "hide";
                     }
                     this.className = "on";
                     oDivs[this.index].className = "";
                 };
             };
        };
    
 	</script>
 </head>
<body>
<%
	ArrayList <StatisticSingle> saleslist = new ArrayList <StatisticSingle> (); //用来存储商品
	while(rs.next()){
		//定义一个BookSingle类对象来封装商品信息			
		StatisticSingle single = new StatisticSingle();
		single.setTypeName(rs.getString("typeName"));
		single.setSalesCount(rs.getInt("salesTotal"));
		saleslist.add(single); //保存商品到saleslist集合对象中
}
%>

<!-- HTML页面布局 -->
<div id="tabs">
	<h3 class="title">销售统计结果显示</h3>
	<hr/>
    <ul>
        <li class="on">表格</li>
        <li>柱形图</li>
        <li>饼图</li>
    </ul>
    <div>
    	<table width="400">
    		<tr height="40" style="color:#fff;">
    			<td>类别</td><td width="30%" align="right">销量&nbsp;&nbsp;</td><td colspan="2">&nbsp;</td>
    		</tr>
         	<% if(saleslist==null||saleslist.size()==0){ %>
         	<tr height="200"><td align="center" colspan="4">没有选项可显示！</td></tr>
         	<% 
         	}else{
              	int i=0;
              	int j=0;
              	while(j<saleslist.size()){
              		StatisticSingle single=(StatisticSingle)saleslist.get(j);
              		numAll += single.getSalesCount();
              		j++;
              	}
              	while(i<saleslist.size()){
              		StatisticSingle single=(StatisticSingle)saleslist.get(i);
         		    int numOne= single.getSalesCount();
         		    float picLen=numOne*145/numAll;						//计算图片长度
         		    float per=numOne*100/numAll;							//计算票数所占的百分比
         		    float doPer=((int)((per+0.05f)*10))/10f;				//保留百分比后的一位小数，并进行四舍五入
         	%>
         	<tr height="30">
         		<td><%=single.getTypeName() %></td>
            	<td width="30%" align="right"><%=single.getSalesCount() %> 本&nbsp;&nbsp;</td> 
         		<td><img src="images/count.jpg" width="<%=picLen%>" height="15" alt="柱状图：<%=single.getTypeName()%>"/></td>
                <td width="15%" align="right"><%=doPer%>%</td>
         	</tr>                        
         	<% 
              		i++;
             	}
         	} 
         	%>
         	<tr height="40">
		 		<td colspan="4" align="center"><a href="salesinfo.jsp" class="getback">返回</a></td>
         	</tr>
         </table>
    </div>
    <%
    StandardChartTheme standardChartTheme = new StandardChartTheme("CN");		//创建主题样式
    standardChartTheme.setExtraLargeFont(new Font("隶书", Font.BOLD, 20)); 		//设置标题字体
    standardChartTheme.setRegularFont(new Font("微软雅黑", Font.PLAIN, 15)); 		//设置图例的字体
    standardChartTheme.setLargeFont(new Font("微软雅黑", Font.PLAIN, 15)); 		//设置轴向的字体
    ChartFactory.setChartTheme(standardChartTheme);							//设置主题样式
    DefaultCategoryDataset dataset1=new DefaultCategoryDataset();
	for(int i=0;i<saleslist.size();i++){
		StatisticSingle single1=(StatisticSingle)saleslist.get(i);
		dataset1.addValue(single1.getSalesCount(),"", single1.getTypeName());
	}
	//创建JFreeChart组件的图表对象
	JFreeChart chart=ChartFactory.createBarChart3D(
									"不同类别图书销售",		//图表标题
									"类别",		//x轴的显示标题
									"销量",			//y轴的显示标题
									dataset1,	//数据集
									PlotOrientation.VERTICAL,//图表方向(垂直)
									false,		//是否包含图例
									false,		//是否包含提示
									false		//是否包含URL
									);
	//设置图表的文件名
	// 固定用法
	ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
	String fileName=ServletUtilities.saveChartAsPNG(chart,400,270,info,session);
	String url=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName;
	%>
    <div class="hide">
		<img alt="销量统计" src="<%=url%>"/>
		<br/>
		<a href="salesinfo.jsp" class="getback">返回</a>
    </div>
    <%
    
	DefaultPieDataset dataset2=new DefaultPieDataset();
    for(int i=0;i<saleslist.size();i++){
    	StatisticSingle single2=(StatisticSingle)saleslist.get(i);
    	dataset2.setValue(single2.getTypeName(), single2.getSalesCount());
    }
	//创建JFreeChart组件的图表对象
	JFreeChart chart2=ChartFactory.createPieChart(
										"不同类别图书销售",	//图表标题
										dataset2,				//数据集
										true,					//是否包含图例
										false,					//是否包含图例说明
										false					//是否包含连接
										);
	//设置图表的文件名
	// 固定用法
	ChartRenderingInfo info2 = new ChartRenderingInfo(new StandardEntityCollection());
	String fileName2=ServletUtilities.saveChartAsPNG(chart2,400,270,info2,session);
	String url2=request.getContextPath()+"/servlet/DisplayChart?filename="+fileName2;
	%>
    <div class="hide">
		<img alt="销量统计" src="<%=url2 %>"/>
		<br/>
		<a href="salesinfo.jsp" class="getback">返回</a>
    </div>
    
</div>
</body>
</html>