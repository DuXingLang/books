package toolbean;

import java.util.ArrayList;
import valuebean.BookSingle;

public class ShopCar {
	private ArrayList buylist = new ArrayList();

	public ArrayList getBuylist() {
		return buylist;
	}

	/*
	 * @功能 向购物车中添加商品
	 * @参数 single为GoodsSingle类对象，封装了要添加的商品信息
	 */
	public void addItem(BookSingle single) {
		if (single != null) {
			if (buylist.size() == 0) { // 如果buylist中不存在任何商品
				BookSingle temp = new BookSingle();
				temp.setBookId(single.getBookId());
				temp.setBookType(single.getBookType());
				temp.setBookName(single.getBookName());
				temp.setBookAuthor(single.getBookAuthor());
				temp.setBookPublish(single.getBookPublish());
				temp.setBookImg(single.getBookImg());
				temp.setBookPrice(single.getBookPrice());
				temp.setBookNum(single.getBookNum());
				buylist.add(temp); // 存储商品
			} else { // 如果buylist中存在商品
				int i = 0;
				for (; i < buylist.size(); i++) { // 遍历buylist集合对象，判断该集合中是否已经存在当前要添加的商品
					BookSingle temp = (BookSingle) buylist.get(i); // 获取buylist集合中当前元素
					if (temp.getBookId().equals(single.getBookId())) { // 判断从buylist集合中获取的当前商品的名称是否与要添加的商品的名称相同
						temp.setBookNum(temp.getBookNum() + 1); // 如果相同，说明已经购买了该商品，只需要将商品的购买数量加1
						break; // 结束for循环
					}
				}
				if (i >= buylist.size()) { // 说明buylist中不存在要添加的商品
					BookSingle temp = new BookSingle();
					temp.setBookId(single.getBookId());
					temp.setBookType(single.getBookType());
					temp.setBookName(single.getBookName());
					temp.setBookAuthor(single.getBookAuthor());
					temp.setBookPublish(single.getBookPublish());
					temp.setBookImg(single.getBookImg());
					temp.setBookPrice(single.getBookPrice());
					temp.setBookNum(single.getBookNum());
					buylist.add(temp); // 存储商品
				}
			}
		}
	}

	/**
	 * @功能 从购物车中移除指定名称的商品
	 * @参数 name表示商品名称
	 */
	public void removeItem(String id) {
		for (int i = 0; i < buylist.size(); i++) { // 遍历buylist集合，查找指定名称的商品
			BookSingle temp = (BookSingle) buylist.get(i); // 获取集合中当前位置的商品
			// 如果商品的名称为name参数指定的名称
			if (temp.getBookId().equals(MyTools.toChinese(id))) {
				if (temp.getBookNum() > 1) { // 如果商品的购买数量大于1
					temp.setBookNum(temp.getBookNum() - 1); // 则将购买数量减1
					break; // 结束for循环
				} else if (temp.getBookNum() == 1) { // 如果商品的购买数量为1
					buylist.remove(i); // 从buylist集合对象中移除该商品
				}
			}
		}
	}

	/**
	 * @功能 清空购物车
	 */
	public void clearCar() {
		buylist.clear(); // 清空buylist集合对象
	}
}
