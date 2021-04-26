package com.example.demo.request;

import java.util.HashMap;
import java.util.Map;

public class RequestInfo {

    private static Map<String, Object> infoMap = new HashMap<>();

    public static void setInfo(String key, Object info){
        infoMap.put(key, info);
    }

    public static Object getInfo(String key){
        return infoMap.get(key);
    }
}
