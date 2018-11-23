package com.hwua.ssm.entity;

import lombok.*;
import lombok.experimental.Accessors;

import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Accessors(chain = true)//链式传参数
public class User implements Serializable {

    private Integer id;

    private String username;

    private String password;

    private String realname;

    private String phone;

    private String email;

    private String status;

    /*
     * 实体类中的三件套：无参构造（如果有有参构造的话，一定要加一个无参构造）
     *   getter和setter
     *   toString。用来打印信息
     *   快捷键：alt+insert
     *       有些电脑是需要和fn键配合使用的：fn+alt+insert
     * */
/*
   //凡是基本数据类型，8中，byte，short,char,int,float,long,double ,boolean
    //我们有时候提一个概念叫简单数据类型=8种基本数据类型+String
    //在实体类中凡是对应的基本数据类型，都试用期封装类型
*/
}