package com.example.demo.ant_algorithm;

public class PublicFun {
	public static final double ALPHA = 2.0;// 信息启发式因子，信息素的重要程度 2.0
	public static final double BETA = 3.0;// 期望启发式因子, 城市间距离的重要程度 3.0
	public static final double ROU = 0.5;// 信息素残留系数 0.5
	public static final double SIGMA = 0.5;// 动态挥发系数的控制参数
	public static final double P_BEST = 0.05;

	public static int N_IT_COUNT = 200;// 迭代次数 200
	public static int N_CITY_COUNT = 15;// 城市数量
	public static int N_ANT_COUNT = N_CITY_COUNT * 2;// 蚂蚁数量
	public static double DYNAMIC_ROU = 0.8;// 动态信息素残留系数

	public static double DBQ = 100;// 总信息素
	public static final double DB_MAX = Math.pow(10, 9);// 一个标志数,用来初始化一个比较大的最优路径

	// 两两城市间的信息量
	public static double[][] g_Trial;

	// 两两城市间的距离
	public static Double[][] g_Distance;

	// 返回指定范围内的随机整数
	public static int rnd(int nLow, int nUpper) {
		return (int) (Math.random() * (nUpper - nLow) + nLow);
	}

	// 返回指定范围内的随机浮点数
	public static double rnd(double dbLow, double dbUpper) {
		return Math.random() * (dbUpper - dbLow) + dbLow;
	}
}
