package com.example.demo.ant_algorithm;

import com.example.demo.utils.IOUtils;

import java.util.ArrayList;
import java.util.List;

public class Tsp {

	//蚂蚁数组
    public Ant[] m_antAry = new Ant[PublicFun.N_ANT_COUNT];
    //定义一组蚂蚁,用来保存每一次搜索中较优结果,不参与搜索
    public Ant[] m_betterAnts = new Ant[PublicFun.N_IT_COUNT];
    //定义一个蚂蚁变量,用来保存最终最优结果,不参与搜索
    public Ant m_bestAnt;
    //信息量的上界
    public double tau_max;
    //信息量的下界
    public double tau_min;

	/*
     * 初始化数据
     */
    public void InitData() throws Exception {
        //通过贪心算法计算最优路径
        //int pathLength = getShortestPathByGA();
        //初始化tau_max
        //tau_max = 1 / ((1 - PublicFun.ROU) * pathLength);
        //初始化tau_min
        //初始化所有蚂蚁
        PublicFun.g_Trial = new double[PublicFun.N_CITY_COUNT][PublicFun.N_CITY_COUNT];
        m_bestAnt = new Ant();
        for (int i = 0; i < PublicFun.N_ANT_COUNT; i++) {
            m_antAry[i] = new Ant();
        }
        for (int i = 0; i < PublicFun.N_IT_COUNT; i++) {
            m_betterAnts[i] = new Ant();
            m_betterAnts[i].m_dbPathLength = PublicFun.DB_MAX;//把较优蚂蚁的路径长度设置为一个很大值
        }
        //先把最优蚂蚁的路径长度设置为一个很大值
        m_bestAnt.m_dbPathLength = PublicFun.DB_MAX;
        //初始化信息素
        for (int i = 0; i < PublicFun.N_CITY_COUNT; i++) {
            for (int j = 0; j < PublicFun.N_CITY_COUNT; j++) {
                //PublicFun.g_Trial[i][j] = tau_max;
                PublicFun.g_Trial[i][j] = 1.0;
            }
        }
        Iterator();//开始迭代
    }

    /*
     * 更新环境信息素
     */

    public void updateTrial(Ant m_bestAnt, Ant m_betterAnt) {
        //临时数组,保存各只蚂蚁在两两城市间新留下的信息素
        double[][] dbTempAry = new double[PublicFun.N_CITY_COUNT][PublicFun.N_CITY_COUNT];
        //全部设置为0;
        for (int i = 0; i < PublicFun.N_CITY_COUNT; i++) {
            for (int j = 0; j < PublicFun.N_CITY_COUNT; j++) {
                dbTempAry[i][j] = 0.0;
            }
        }
        //计算新增加的信息素,保存到临时变量
        for(int i = 0; i < PublicFun.N_ANT_COUNT; i++) {
            for (int j = 0; j < PublicFun.N_CITY_COUNT; j++) {
                int m = m_antAry[i].m_nPath[j];
                int n = m_antAry[i].m_nPath[(j + 1) % PublicFun.N_CITY_COUNT];
                dbTempAry[n][m] = dbTempAry[n][m] + PublicFun.DBQ / m_antAry[i].m_dbPathLength;
                //dbTempAry[n][m] = limit(dbTempAry[n][m] + PublicFun.DBQ / m_antAry[i].m_dbPathLength);
                dbTempAry[m][n] = dbTempAry[n][m];
            }
        }
        //对全局最优路径和当前迭代次数中的最优路径进行信息量的增强
        for (int i = 0; i < PublicFun.N_CITY_COUNT; i++){
            int m = m_bestAnt.m_nPath[i];
            int n = m_bestAnt.m_nPath[(i + 1) % PublicFun.N_CITY_COUNT];
            int x = m_betterAnt.m_nPath[i];
            int y = m_betterAnt.m_nPath[(i + 1) % PublicFun.N_CITY_COUNT];
            dbTempAry[m][n] = dbTempAry[m][n] + PublicFun.DBQ / m_bestAnt.m_dbPathLength;
            dbTempAry[x][y] = dbTempAry[x][y] + PublicFun.DBQ / m_betterAnt.m_dbPathLength;
            //dbTempAry[m][n] = limit(dbTempAry[m][n] + PublicFun.DBQ / m_bestAnt.m_dbPathLength);
            //dbTempAry[x][y] = limit(dbTempAry[x][y] + PublicFun.DBQ / m_betterAnt.m_dbPathLength);
            dbTempAry[n][m] = dbTempAry[m][n];
            dbTempAry[y][x] = dbTempAry[x][y];
        }
        //更新环境信息素
        for (int i = 0; i < PublicFun.N_CITY_COUNT; i++) {
            for (int j = 0; j < PublicFun.N_CITY_COUNT; j++) {
                //最新的环境信息素 = 留存的信息素 + 新留下的信息素
                //PublicFun.g_Trial[i][j] = PublicFun.g_Trial[i][j] * PublicFun.ROU + dbTempAry[i][j];
                PublicFun.g_Trial[i][j] = PublicFun.g_Trial[i][j] * PublicFun.DYNAMIC_ROU + dbTempAry[i][j];
            }
        }
        //System.out.println(PublicFun.DYNAMIC_ROU);
        //动态挥发系数
        PublicFun.DYNAMIC_ROU = PublicFun.SIGMA * PublicFun.DYNAMIC_ROU + Math.pow(1 - PublicFun.DYNAMIC_ROU, 2.0);
        //更新tau_max和tau_min
        //tau_max = 1 / ((1 - PublicFun.ROU) * m_betterAnt.m_dbPathLength);
        //tau_min = 2 * tau_max * (1 - Math.pow(PublicFun.P_BEST, 1 / PublicFun.N_CITY_COUNT))
        //        / ((PublicFun.N_CITY_COUNT - 2) * Math.pow(PublicFun.P_BEST, 1 / PublicFun.N_CITY_COUNT) * m_betterAnt.m_dbPathLength);
    }


    /*
     * 迭代
     */
    public void Iterator() { /*迭代次数内进行循环*/
        for (int i = 0; i < PublicFun.N_IT_COUNT; i++) { /*每只蚂蚁搜索一遍*/
            for (int j = 0; j < PublicFun.N_ANT_COUNT; j++){
                m_antAry[j].Search();
            }
            for (int j = 0; j < PublicFun.N_ANT_COUNT; j++) {
                if (m_antAry[j].m_dbPathLength < m_betterAnts[i].m_dbPathLength){
                    m_betterAnts[i] = (Ant) m_antAry[j].clone();
                }
            }
            //找出最优蚂蚁
            if (m_betterAnts[i].m_dbPathLength < m_bestAnt.m_dbPathLength) {
                m_bestAnt = m_betterAnts[i];
            }
            //更新信息量函数添加当前迭代次数中最有路径和全局最优路径
            updateTrial(m_bestAnt, m_betterAnts[i]);
            //根据迭代次数动态变化信息量总量，使用该改进方法时要将该属性的final修饰去掉
            /*if (i > 50){
                PublicFun.DBQ *= 0.004 * i;
            }*/
        }
        getBetterAnt();/*输出每次的较优路径*/
        getBestAnt();/*输出最佳路径*/
    }
    /*
     * 输出最佳路径到控制台.
     */
    public void getBestAnt(){
        System.out.println("最佳路径:");
        System.out.println("路径:" + getAntPath(m_bestAnt) + "长度:" + getAntLength(m_bestAnt));
    }

    /*
     * 输出每次的较优路径到控制台.(暂不使用,但保留)
     */
    public void getBetterAnt() {
        System.out.println("每一次的较优路径:");
        for (int i = 0; i < m_betterAnts.length; i++) {
             System.out.println("(" + i + ") 路径:" + getAntPath(m_betterAnts[i]) + "长度:" + getAntLength(m_betterAnts[i]));
        }
    }

    /*
     * 返回蚂蚁经过的路径
     */
    public String getAntPath(Ant ant) {
        String s = "" ;
        for(int i = 0; i < ant.m_nPath.length; i++) {
            s += ant.m_nPath[i] + "-";
        }
        s += ant.m_nPath[0];  //蚂蚁最后要回到开始城市
        return s;
    }
    /*
     * 返回蚂蚁经过的长度
     */
    public double getAntLength(Ant ant) {
        return ant.m_dbPathLength;
    }

    //通过贪心算法求最短路径
    private int getShortestPathByGA() throws Exception {
        //获取距离矩阵
        //Double[][] distances = PublicFun.g_Distance;
        //Double[][] distances = IOUtils.getData();
        Double[][] distances = IOUtils.getDataByCoordinate("eil51");
        int length = 0;
        List<Integer> allow = new ArrayList<>();
        allow.add(0);
        int i = 0;
        while (allow.size() < 51){
            double path = Double.MAX_VALUE;
            int flag = 0;
            for (int j = 0; j < 51; j++){
                if (j == i || allow.contains(j)){
                    continue;
                }
                if (distances[i][j] < path){
                    path = distances[i][j];
                    flag = j;
                }
            }
            i = flag;
            allow.add(i);
            length += path;
        }
        length += distances[i][0];
        return length;
    }

    //将信息素限制在tau_min和tau_min之间
    private double limit(double num){
        if (num > tau_max) {
            return tau_max;
        }
        if (num < tau_min){
            return tau_min;
        }
        return num;
    }

    public static void main(String[] args) throws Exception {
        Tsp tsp = new Tsp();
        int res = tsp.getShortestPathByGA();
        System.out.println(res);
        //输出40551
        //输出676
    }
}
