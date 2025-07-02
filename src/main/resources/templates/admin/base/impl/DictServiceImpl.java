package com.sun.project.common.dict.service;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sun.project.common.dict.mapper.SysDictMapper;
import com.sun.project.common.entity.common.Option;
import com.sun.project.common.entity.sys.SysDict;
import com.sun.project.common.enums.common.State;
import com.sun.project.common.i18n.I18nUtils;
import com.sun.project.common.vo.sys.SysDictVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 * 系统字典表 服务实现类
 * </p>
 *
 * @author sun
 * @since 2024-11-27
 */
@Service
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements DictService {
    @Override
    public SysDict getByCode(String code, String lng) {
        SysDict dist = this.getOne(Wrappers.lambdaQuery(SysDict.class)
                .eq(SysDict::getCode, code)
                .eq(SysDict::getState, State.Success.getCode()));
        if (dist != null) {
            SwitchLang(dist, lng);
            return dist;
        }
        return null;
    }

    private void SwitchLang(SysDict dist, String lng) {
        lng = lng == null ? I18nUtils.getMessage("lng") : lng;
        switch (lng) {
            case "zh_CN":
                dist.setName(dist.getNameCn());
                break;
            case "en_US":
                dist.setName(dist.getName());
                break;
            default:
                break;
        }
    }

    @Override
    public Page<SysDictVo> list(SysDictVo dict) {
        //分页
        Page<SysDict> page = new Page<>(dict.getCurrent(), dict.getPageSize());
        //查询
        LambdaQueryWrapper<SysDict> query = Wrappers.lambdaQuery(SysDict.class);
        query
                .like(StringUtils.isNotBlank(dict.getCode()), SysDict::getCode, dict.getCode())
                .like(StringUtils.isNotBlank(dict.getNameCn()), SysDict::getNameCn, dict.getNameCn())
                .like(StringUtils.isNotBlank(dict.getRemark()), SysDict::getRemark, dict.getRemark())
                .like(StringUtils.isNotBlank(dict.getVal()), SysDict::getVal, dict.getVal())
                .like(StringUtils.isNotBlank(dict.getName()), SysDict::getName, dict.getName())
                .eq(StringUtils.isNotBlank(dict.getId()), SysDict::getId, dict.getId())
                .eq(SysDict::getState, State.Success.getCode())
                .orderByAsc(SysDict::getSortNum);
        if (dict.getId() == null && dict.getName() == null && dict.getNameCn() == null && dict.getVal() == null && dict.getCode() == null && dict.getRemark() == null) {
            query.isNull(SysDict::getParent);
        }
        Page<SysDict> dictPage = page(page, query);
        List<SysDict> records = dictPage.getRecords();
        //父code
        List<String> parentIds = records.stream().map(SysDict::getCode).collect(Collectors.toList());
        //所有子资源
        List<SysDict> list = list(Wrappers.lambdaQuery(SysDict.class)
                .eq(SysDict::getState, State.Success.getCode())
                .notIn(SysDict::getCode, parentIds)
                .isNotNull(SysDict::getParent));
        //添加所有子资源
        records.addAll(list);
        //所有资源
        LinkedHashMap<String, SysDictVo> sysDict = new LinkedHashMap<>();
        //将父code作为key，资源作为value,放入map中并转化为vo
        List<SysDictVo> dictVoList = records.stream().map(item -> {
            SysDictVo vo = new SysDictVo();
            BeanUtils.copyProperties(item, vo);
            vo.setKey(item.getId());
            if (!sysDict.containsKey(item.getCode())) {
                sysDict.put(item.getCode(), vo);
            }
            return vo;
        }).collect(Collectors.toList());
        //构建树形结构
        for (SysDictVo item : dictVoList) {
            if (item.getParent() != null) {
                SysDictVo parent = sysDict.get(item.getParent());
                if (parent != null) {
                    if (parent.getChildren() == null) {
                        parent.setChildren(new ArrayList<>());
                    }
                    parent.getChildren().add(item);
                }
            }
        }
        Page<SysDictVo> voPage = new Page<>();
        voPage.setRecords(sysDict.values()
                .stream()
                .filter(item -> parentIds.contains(item.getCode()))
                .collect(Collectors.toList()));
        voPage.setTotal(dictPage.getTotal());
        return voPage;
    }

    @Override
    public SysDict info(String id) {
        return getById(id);
    }

    @Override
    public boolean delete(String id) {
        SysDictVo vo = new SysDictVo();
        vo.setId(id);
        ArrayList<String> ids = new ArrayList<>();
        Page<SysDictVo> list = list(vo);
        if (!list.getRecords().isEmpty() && list.getRecords().size() == 1) {
            Stack<SysDictVo> stack = new Stack<>();
            stack.push(list.getRecords().get(0));
            while (!stack.isEmpty()) {
                SysDictVo item = stack.pop();
                ids.add(item.getId());
                if (item.getChildren() != null) {
                    stack.addAll(item.getChildren());
                }
            }
        }
        return update(Wrappers.lambdaUpdate(SysDict.class)
                .set(SysDict::getState, State.Delete.getCode())
                .in(SysDict::getId, ids));
    }

    @Override
    public List<Option> getOptions(String parentCode) {
        List<SysDict> list = getByParentCode(parentCode);
        if (list.isEmpty()) {
            return Collections.emptyList();
        }
        list.forEach(sysDict -> SwitchLang(sysDict, null));
        return list.stream().map(item -> new Option(item.getName(), item.getCode())).collect(Collectors.toList());
    }

    @Override
    public List<SysDict> select() {
        return this.list(Wrappers.lambdaQuery(SysDict.class)
                .eq(SysDict::getState, State.Success.getCode())
                .orderByAsc(SysDict::getSortNum));
    }

    @Override
    public String getValue(String code) {
        SysDict dict = getByCode(code, null);
        return dict == null ? null : dict.getVal();
    }

    private List<SysDict> getByParentCode(String parentCode) {
        return this.list(Wrappers.lambdaQuery(SysDict.class)
                .eq(SysDict::getParent, parentCode)
                .eq(SysDict::getState, State.Success.getCode()));
    }

}
