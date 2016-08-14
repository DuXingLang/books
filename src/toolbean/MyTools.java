package toolbean;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MyTools {
	/**
	 * @功能 将int型数据转换为String型数据
	 * @参数 num为要转换的int型数据
	 * @返回值 String类型
	 */
	public static String intToStr(int num){
		return String.valueOf(num);
	}
	/** 
	 * @功能 比较时间。
	 * @参数 today当前时间，temp为上次投票时间。这两个参数都是以毫秒显示的时间
	 * @返回值 String类型 
	 */
	public static String compareTime(long today,long temp){
		int limitTime=0;								//设置限制时间为60分钟	
		long count=today-temp;							//计算当前时间与上次投票时间相差的毫秒数(该结果一定是大于等于0)
		if(count<=limitTime*60*1000)					//如果相差小于等于60分钟(1分=60秒，1秒=1000毫秒)
			return "no";
		else											//如果相差大于60分钟
			return "yes";
	}
	/**
	 * @功能 格式化时间为指定格式。首先通过Date类的构造方法根据给出的毫秒数获取一个时间，然后将该时间转换为指定格式，如"年-月-日 时:分:秒"
	 * @参数 ms为毫秒数
	 * @返回值 String类型
	 */
	public static String formatDate(long ms){
		Date date=new Date(ms);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strDate=format.format(date);
		return strDate;
	}
	public static int strToint(String str) { //将String型数据转换为int型数据的方法
		if(str==null||str.equals(""))
			str="0";
		int i=0;
		try{
			i=Integer.parseInt(str);
		}catch(NumberFormatException e){
			i=0;
			e.printStackTrace();
		}
		return i;
	}
	public static String toChinese(String str) {  //进行转码操作的方法
		if(str==null)
			str="";
		try{
			str=new String(str.getBytes("ISO-8859-1"),"gb2312");
		}catch(UnsupportedEncodingException e){
			str="";
			e.printStackTrace();
		}
		return str;
	}
}
