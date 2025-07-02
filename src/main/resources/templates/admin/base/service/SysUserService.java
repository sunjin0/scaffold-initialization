package com.sun.project.api.service.sys;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sun.project.common.entity.sys.SysUser;
import com.sun.project.common.exception.ServerException;
import com.sun.project.common.vo.sys.SysResourceVo;
import com.sun.project.common.vo.sys.SysUserVo;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

/**
 * 系统用户服务
 *
 * @author sun
 * @since 2024/09/11
 */
public interface SysUserService extends IService<SysUser> {

    /**
     * 注册
     *
     * @param sysUser SYS 用户
     * @return {@link Boolean }
     */
    @ApiOperation("注册")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "username", value = "用户名", required = true),
                    @ApiImplicitParam(name = "email", value = "邮箱", required = true),
                    @ApiImplicitParam(name = "password", value = "密码", required = true),
            }
    )
    @PostMapping(value = "/register")
    Boolean register(SysUserVo sysUser) throws ServerException;

    /**
     * 重置密码
     *
     * @param sysUser SYS 用户
     * @return {@link Boolean }
     */
    @ApiOperation("重置密码")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "email", value = "邮箱", required = true),
                    @ApiImplicitParam(name = "password", value = "密码", required = true),
            }
    )
    @PostMapping(value = "/resetPassword")
    Boolean resetPassword(SysUserVo sysUser) throws ServerException;

    /**
     * 验证
     *
     * @param sysUser SYS 用户
     * @return {@link Boolean }
     */
    @ApiOperation("验证账号密码")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "username", value = "用户名", required = true),
                    @ApiImplicitParam(name = "password", value = "密码", required = true),
            }
    )
    @PostMapping(value = "/verify")
    Boolean verify(SysUserVo sysUser) throws ServerException;

    /**
     * 验证帐户
     *
     * @param sysUser SYS 用户
     * @return {@link String } 令牌
     */
    @ApiOperation("验证帐户邮箱")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "email", value = "邮箱", required = true),
                    @ApiImplicitParam(name = "verificationCode", value = "验证码", required = true),

            }
    )
    @PostMapping(value = "/login")
    SysUserVo login(SysUserVo sysUser) throws ServerException;


    /**
     * 按用户 ID 获取角色 ID
     *
     * @param userId 用户 ID
     * @return {@link List }<{@link Integer }>
     */
    @ApiOperation("根据用户id查询角色Ids")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userId", value = "用户id", required = true),
            @ApiImplicitParam(name = "Authorization", value = "访问令牌", required = true, dataType = "string", paramType = "header")
    })
    @GetMapping(value = "/roleIds")
    List<Integer> getRoleIdsByUserId(String userId);

    /**
     * 绑定角色
     *
     * @param userId  用户 ID
     * @param roleIds 角色 ID
     * @return {@link Boolean }
     */
    @ApiOperation("绑定角色")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "userId", value = "用户id", required = true),
                    @ApiImplicitParam(name = "roleIds", value = "角色id集合", required = true),
                    @ApiImplicitParam(name = "Authorization", value = "访问令牌", required = true, dataType = "string", paramType = "header")
            }
    )
    @PostMapping(value = "/bindRole")
    Boolean bindRole(String userId, List<Integer> roleIds);

    /**
     * 获取路由器
     *
     * @return {@link List }<{@link SysResourceVo }>
     */
    @ApiOperation("获取路由器")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "Authorization", value = "访问令牌", required = true, dataType = "string", paramType = "header")
            }
    )
    @PostMapping(value = "/getRouters")
    List<SysResourceVo> getRouters();

    @ApiOperation("管理员详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Authorization", value = "访问令牌", required = true, dataType = "string", paramType = "header")
    })
    @GetMapping("/detail")
    SysUserVo detail();

    @ApiOperation("发送登陆验证码")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "email", value = "邮箱", required = true),
            }
    )
    @PostMapping("/sendVerificationCode")
    void sendVerificationCode(String email);

    @ApiOperation("退出登入")
    @ApiImplicitParams(
            {
                    @ApiImplicitParam(name = "Authorization", value = "访问令牌", required = true, dataType = "string", paramType = "header")
            }
    )
    @PostMapping("/logout")
    boolean logout();
}
