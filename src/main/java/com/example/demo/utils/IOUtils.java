package com.example.demo.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class IOUtils {

    public static void main(String[] args) {
        Double[][] res = getDataByCoordinate("eil51");
        System.out.println(res.length);
        for (int i = 0; i < res.length; i++){
            for (int j = 0; j < res[0].length; j++){
                System.out.print(res[i][j] + " ");
            }
            System.out.println();
        }
    }

    public static Double[][] getData(){
        Double[][] res = null;
        File file = new File("D:/Project/Travel_planning_system/src/main/resources/data/tsp.txt");
        try{
            int i = 0;
            BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
            String s = br.readLine();
            String[] numsOfString = s.split("  ");
            res = new Double[numsOfString.length][numsOfString.length];
            for (int j = 0; j < numsOfString.length; j++){
                res[i][j] = new Double(numsOfString[j]);
            }
            i++;
            while((s = br.readLine()) != null){//使用readLine方法，一次读一行
                numsOfString = s.split("  ");
                for (int j = 0; j < numsOfString.length; j++){
                    res[i][j] = new Double(numsOfString[j]);
                }
                i++;
            }
            br.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return res;
    }

    public static Double[][] getDataByCoordinate(String fileName){
        Double[][] res = null;
        Double[][] coordinate = null;
        Integer row = 0;
        File file = new File("D:/Project/Travel_planning_system/src/main/resources/data/" + fileName + ".txt");
        try{
            int i = 0;
            BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
            String s = br.readLine();
            row = Integer.valueOf(s);
            coordinate = new Double[row][2];
            res = new Double[row][row];
            while((s = br.readLine()) != null){//使用readLine方法，一次读一行
                String[] numsOfString = s.split(" ");
                coordinate[i][0] = new Double(numsOfString[1]);
                coordinate[i][1] = new Double(numsOfString[2]);
                i++;
            }
            br.close();
            for (int x = 0; x < row; x++){
                res[x][x] = Double.MAX_VALUE;
            }
            for (int x = 0; x < row; x++){
                for (int y = x + 1; y < row; y++){
                    double x1 = coordinate[x][0];
                    double y1 = coordinate[x][1];
                    double x2 = coordinate[y][1];
                    double y2 = coordinate[y][1];
                    res[x][y] = Math.round(Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2))) / 1.0;
                    res[y][x] = res[x][y];
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return res;
    }
}
