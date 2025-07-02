package com.sun.project.impl.sys;


import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sun.project.api.mapper.sys.SysResourceMapper;
import com.sun.project.api.service.sys.SysResourceService;
import com.sun.project.common.entity.common.BaseEntity;
import com.sun.project.common.entity.sys.SysResource;
import com.sun.project.common.enums.common.State;
import com.sun.project.common.enums.sys.ResourceType;
import com.sun.project.common.i18n.I18nUtils;
import com.sun.project.common.vo.sys.SysResourceVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 资源表 服务实现类
 * </p>
 *
 * @author sun
 * @since 2024-11-12
 */
@Service
public class SysResourceServiceImpl extends ServiceImpl<SysResourceMapper, SysResource> implements SysResourceService {

    @Override
    public Page<SysResourceVo> list(SysResource sysResource) {
        // 获取国际化语言
        String lng = I18nUtils.getMessage("lng");
        // 分页
        Page<SysResource> resourcePage = new Page<>(sysResource.getCurrent(), sysResource.getPageSize());
        // 查询条件
        Wrapper<SysResource> queryWrapper = Wrappers.lambdaQuery(SysResource.class)
                .eq(SysResource::getState, State.Success.getCode())
                .like(StringUtils.isNotBlank(sysResource.getNameCn()), SysResource::getNameCn, sysResource.getNameCn())
                .like(StringUtils.isNotBlank(sysResource.getName()), SysResource::getName, sysResource.getName())
                .like(StringUtils.isNotBlank(sysResource.getPath()), SysResource::getPath, sysResource.getPath())
                .like(StringUtils.isNotBlank(sysResource.getType()), SysResource::getType, sysResource.getType())
                .like(StringUtils.isNotBlank(sysResource.getDescription()), SysResource::getDescription, sysResource.getDescription())
                .eq(sysResource.getName() == null
                        && sysResource.getNameCn() == null
                        && sysResource.getPath() == null
                        && sysResource.getType() == null
                        && sysResource.getDescription() == null, SysResource::getParentId, 0)
                .orderByAsc(SysResource::getSortNum);
        // 查询
        Page<SysResource> page = this.page(resourcePage, queryWrapper);
        List<SysResourceVo> sysResourceVos = page.getRecords().stream().map(record -> {
            SysResourceVo sysResourceVo = new SysResourceVo();
            BeanUtils.copyProperties(record, sysResourceVo);
            sysResourceVo.setKey(record.getId());
            sysResourceVo.setTitle("en_US".equals(lng) ? record.getName() : record.getNameCn());
            return sysResourceVo;
        }).collect(Collectors.toList());
        // 获取父级id
        List<String> parentIds = sysResourceVos.stream().map(SysResourceVo::getId).collect(Collectors.toList());
        // 查询非父id的所有子资源
        List<SysResourceVo> list = this.list(Wrappers.lambdaQuery(SysResource.class)
                .eq(SysResource::getState, State.Success.getCode())
                .notIn(SysResource::getId, parentIds)).stream().map(record -> {
            SysResourceVo sysResourceVo = new SysResourceVo();
            BeanUtils.copyProperties(record, sysResourceVo);
            sysResourceVo.setKey(record.getId());
            sysResourceVo.setTitle("en_US".equals(lng) ? record.getName() : record.getNameCn());
            return sysResourceVo;
        }).collect(Collectors.toList());
        sysResourceVos.addAll(list);
        // 处理父子级关系
        LinkedHashMap<String, SysResourceVo> map = new LinkedHashMap<>();
        sysResourceVos.forEach(v -> {
            if (!map.containsKey(v.getId())) {
                map.put(v.getId(), v);
            }
        });
        Queue<SysResourceVo> queue = new LinkedList<>(sysResourceVos);
        while (!queue.isEmpty()) {
            SysResourceVo poll = queue.poll();
            SysResourceVo parent = map.get(poll.getParentId().toString());
            if (parent != null) {
                if (parent.getChildren() == null) {
                    parent.setChildren(new ArrayList<>());
                }
                parent.getChildren().add(poll);
            }
        }

        Page<SysResourceVo> voPage = new Page<>();
        voPage.setRecords(map.values().stream()
                .filter(vo -> Objects.equals(vo.getType(), ResourceType.ROUTE.getCode()))
                .filter(vo -> parentIds.contains(vo.getId()))
                .sorted(Comparator.comparing(BaseEntity::getSortNum))
                .collect(Collectors.toList()));
        voPage.setTotal(page.getTotal());
        return voPage;
    }
}
