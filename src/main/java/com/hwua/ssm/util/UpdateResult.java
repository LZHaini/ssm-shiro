package com.hwua.ssm.util;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.codec.digest.DigestUtils;

public class UpdateResult {
    private Boolean success;
    private String info;


    public UpdateResult(Boolean success, String info) {
        this.success = success;
        this.info = info;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String toJSONString() {
        JSONObject obj = new JSONObject();
        obj.put("success", success);
        obj.put("info", info);
        return obj.toJSONString();
    }

    public static void main(String[] args) {
        String str = DigestUtils.md5Hex("123456");
        for (int i = 0; i < 63; i++) {
            str = DigestUtils.md5Hex(str);
        }
        System.out.println(str);
    }
}
