package com.example.demo.ant_algorithm;

import com.example.demo.utils.IOUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Plan {

    /**
     * 优化的地方
     * 1.对全局最优路径和当前迭代次数中最优路径的信息量进行额外的增强，
     * 后者的增强分两种情况，一是只增强当前迭代次数中最优路径（精英蚂蚁算法），二是对路径进行排序增强前w个路径（蚂蚁排序算法），不增强普通路径
     * 2.信息素区间限制：信息量初始化为区间最大值，区间随着迭代不断变化
     * 3.启发式蚂蚁算法：期望启发函数从距离的倒数变化为从起点到当前节点走过的距离加上当前节点与终点的距离，再求倒数（效果比较差）
     * 4.动态挥发系数的蚂蚁算法：挥发系数随着迭代不断变化
     * 5.根据迭代次数动态变化信息量总量，小于50不变（初始值为2），大于50公式为：0.004*初始值*当前迭代次数
     * 6.调整参数：ALPHA = 0.9, BETA = 4, N_ANT_COUNT = 50, N_IT_COUNT = 200, ROU = 0.8
     */
    public static void main(String[] args) throws Exception {
        long start = System.currentTimeMillis();
        /*List<String> places = new ArrayList<>();
        places.add("西湖");
        places.add("西溪国家湿地公园");
        places.add("杭州宋城");
        places.add("灵隐寺");
        places.add("上天竺法喜讲寺");
        places.add("茅家埠");
        places.add("宝石山");
        getShortestPath(places);*/
        getShortestPathByTspData();
        long end = System.currentTimeMillis();
        System.out.println("耗时" + (end - start) + "ms");
    }

    public static List<List<String>> getShortestPath(List<String> places) throws Exception{
        List<List<String>> result = new ArrayList<>();
        //计算各地点的经纬度
        List<LocationEntity> lists = Match.batchQueryLocation(places);
        //地址-坐标映射表
        Map<String, String> locationMap = new HashMap<>();
        for (LocationEntity entity: lists){
            locationMap.put(entity.getAddress(), entity.getLocation());
        }
        //获取距离矩阵
        Double[][] distances = Match.returnShortCut(lists);
        //调用蚁群算法，选出最短路径
        //初始化数据
        PublicFun.g_Distance = distances;
        //城市数量
        PublicFun.N_CITY_COUNT = lists.size();
        //初始化蚂蚁数量
        PublicFun.N_ANT_COUNT = 2 * lists.size();
        //PublicFun.N_ANT_COUNT = 50;
        Tsp tsp = new Tsp();
        tsp.InitData();
        Ant ant = tsp.m_bestAnt;
        System.out.println("蚂蚁走过最佳的路径：" + ant.m_dbPathLength);
        List<String> shortestPath = new ArrayList<>();
        List<String> shortestPlace = new ArrayList<>();
        String path = "";
        for (int i = 0; i < ant.m_nPath.length; i++){
            shortestPlace.add(places.get(ant.m_nPath[i]));
            String location = locationMap.get(places.get(ant.m_nPath[i]));
            shortestPath.add(location);
            path += places.get(ant.m_nPath[i]) + "(" + location + ")" + "-";
        }
        path += places.get(0);
        shortestPath.add(locationMap.get(places.get(ant.m_nPath[0])));
        shortestPlace.add(places.get(ant.m_nPath[0]));
        System.out.println(path);
        result.add(shortestPlace);
        result.add(shortestPath);
        return result;
    }

    public static void getShortestPathByTspData() throws Exception {
        //Double[][] distances = IOUtils.getData();
        Double[][] distances = IOUtils.getDataByCoordinate("eil51");
        PublicFun.g_Distance = distances;
        PublicFun.N_CITY_COUNT = 51;
        PublicFun.N_ANT_COUNT = 102;
        Tsp tsp = new Tsp();
        tsp.InitData();
        Ant ant = tsp.m_bestAnt;
        System.out.println("蚂蚁走过最佳的路径：" + ant.m_dbPathLength);
    }
}
