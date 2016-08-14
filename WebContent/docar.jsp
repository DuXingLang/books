<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@ page import="valuebean.BookSingle"%>
<%@ page import="toolbean.MyTools"%>
<%@ page import="toolbean.Connectdb"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="myCar" class="toolbean.ShopCar" scope="session" />
<%	
	String action = request.getParameter("action");
	int num = MyTools.strToint(request.getParameter("num"));
	System.out.println(num);
	if (action == null)
		action = "";
	if (action.equals("buy")) { //购买商品
		ArrayList bookslist = (ArrayList) session.getAttribute("bookslist");
		int id = MyTools.strToint(request.getParameter("id"));
		BookSingle single = (BookSingle) bookslist.get(id);
		if(single.getBookCount()>num){
			single.setBookNum(num);
			myCar.addItem(single); //调用ShopCar类中的addItem()方法添加商品
			single.setBookCount(single.getBookCount()-num);//点击购买，从数据库获取的结果集中的库存缓存减1；
		}else{
			single.setBookCount(0); //如果库存数量为0，则不能购买
		}
		response.sendRedirect("fenyeShow.jsp");
	} else if (action.equals("remove")) { //移除商品
		ArrayList bookslist = (ArrayList) session.getAttribute("bookslist");
		String bookId = request.getParameter("bookId"); //获取商品名称
		for(int i=0;i<bookslist.size();i++){
			BookSingle single = (BookSingle) bookslist.get(i);
			if(single.getBookId().equals(bookId)){
				single.setBookCount(single.getBookCount()+1);
			}
		}
		myCar.removeItem(bookId); //调用ShopCar类中的removeItem()方法移除商品
		response.sendRedirect("shopcar.jsp");
	} else if (action.equals("clear")) { //清空购物车
		ArrayList bookslist = (ArrayList) session.getAttribute("bookslist");
		ArrayList buylist = (ArrayList)session.getAttribute("buylist");
		for(int i=0;i<buylist.size();i++){
			BookSingle buytemp = (BookSingle) buylist.get(i);
			for(int j = 0;j<bookslist.size();j++){
				BookSingle single = (BookSingle) bookslist.get(j);
				if(buytemp.getBookId().equals(single.getBookId())){
					single.setBookCount(single.getBookCount()+buytemp.getBookNum());
				}
			}
		}
		myCar.clearCar(); //调用ShopCar类中的clearCar()方法清空购物车
		response.sendRedirect("shopcar.jsp");
	}else if(action.equals("pay")){
		Connectdb update1=new Connectdb();
		ArrayList buylist = (ArrayList)session.getAttribute("buylist");
		for(int i=0;i<buylist.size();i++){
			BookSingle buytemp = (BookSingle) buylist.get(i);
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date mydate = new Date();
					String date = dateFormat.format(mydate);
					String bookId = buytemp.getBookId();
					int bookNum = buytemp.getBookNum();
					String sql="update books_table set bookCount=bookCount-"+bookNum+" where bookId='"+bookId+"'";
					update1.executeUpdate(sql);
					String bookName = buytemp.getBookName();
					String bookType = buytemp.getBookType();
					String sql2 = "select * from sales_table where bookId = '"+ bookId+"'";
					ResultSet rs = update1.executeQuery(sql2);
					if(rs.next()){
						String sql3 = "update sales_table set sales=sales+"+bookNum+" where bookId='"+bookId+"'";
						update1.executeUpdate(sql3);
					}else{
						String sql4 = "insert into sales_table values('" + bookId + "','" + bookName + "','" + bookType + "'," 
								+ bookNum + ")";
						update1.executeUpdate(sql4);
					}
					String sql5 = "insert into sales_date(bookId,bookName,bookType,sales,salesDate) values('" 
							+ bookId + "','" + bookName + "','" + bookType + "'," + bookNum + ",'" + date + "')";
					update1.executeUpdate(sql5);
					System.out.println("插入成功！");
		}
		myCar.clearCar(); //调用ShopCar类中的clearCar()方法清空购物车
		response.sendRedirect("shopcar.jsp");
	} else {
		response.sendRedirect("fenyeShow.jsp");
	}
%>