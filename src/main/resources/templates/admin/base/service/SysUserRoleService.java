package com.sun.project.api.service.sys;


import com.baomidou.mybatisplus.extension.service.IService;
import com.sun.project.common.entity.sys.SysUserRole;

import java.util.List;

/**
 * <p>
 * 用户角色表 服务类
 * </p>
 *
 * @author sun
 * @since 2024-11-12
 */
public interface SysUserRoleService extends IService<SysUserRole> {
    /**
     * 用户绑定角色
     *
     * @param userId  用户 ID
     * @param roleIds 角色 ID
     * @return boolean
     */
    boolean saveUserRoleIds(String userId, List<Integer> roleIds);
}
