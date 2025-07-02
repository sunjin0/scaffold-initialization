package com.sun.project.api.service.sys;


import com.baomidou.mybatisplus.extension.service.IService;
import com.sun.project.common.entity.sys.SysRoleResource;

import java.util.List;

/**
 * <p>
 * 角色资源表 服务类
 * </p>
 *
 * @author sun
 * @since 2024-11-12
 */
public interface SysRoleResourceService extends IService<SysRoleResource> {

    List<String> getPermissionByRoleId(String roleId);
}
