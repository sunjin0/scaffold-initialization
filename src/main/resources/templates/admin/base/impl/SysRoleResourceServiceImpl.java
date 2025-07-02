package com.sun.project.impl.sys;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sun.project.api.mapper.sys.SysRoleResourceMapper;
import com.sun.project.api.service.sys.SysRoleResourceService;
import com.sun.project.common.entity.sys.SysRoleResource;
import com.sun.project.common.enums.common.State;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 角色资源表 服务实现类
 * </p>
 *
 * @author sun
 * @since 2024-11-12
 */
@Service
public class SysRoleResourceServiceImpl extends ServiceImpl<SysRoleResourceMapper, SysRoleResource> implements SysRoleResourceService {

    @Override
    public List<String> getPermissionByRoleId(String roleId) {
        LambdaQueryWrapper<SysRoleResource> query = Wrappers.lambdaQuery(SysRoleResource.class);
        query.select(SysRoleResource::getResourceId)
                .eq(SysRoleResource::getRoleId, roleId)
                .eq(SysRoleResource::getState, State.Success.getCode());
        List<SysRoleResource> list = list(query);
        return list.stream().map(resource -> resource.getResourceId().toString()).collect(Collectors.toList());
    }
}
