package com.sun.project.impl.sys;


import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sun.project.api.mapper.sys.SysUserRoleMapper;
import com.sun.project.api.service.sys.SysUserRoleService;
import com.sun.project.common.entity.sys.SysUserRole;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 用户角色表 服务实现类
 * </p>
 *
 * @author sun
 * @since 2024-11-12
 */
@Service
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleMapper, SysUserRole> implements SysUserRoleService {

    @Override
    public boolean saveUserRoleIds(String userId, List<Integer> roleIds) {
        // 删除该用户所有角色
        super.remove(Wrappers.lambdaQuery(SysUserRole.class).eq(SysUserRole::getUserId, userId));
        // 添加角色资源
        List<SysUserRole> sysUserRoles = roleIds.stream().map(roleId -> {
            SysUserRole sysUserRole = new SysUserRole();
            sysUserRole.setUserId(Integer.parseInt(userId));
            sysUserRole.setRoleId(roleId);
            return sysUserRole;
        }).collect(Collectors.toList());
        return super.saveBatch(sysUserRoles);
    }
}
