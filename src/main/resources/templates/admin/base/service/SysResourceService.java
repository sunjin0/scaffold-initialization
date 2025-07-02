package com.sun.project.api.service.sys;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sun.project.common.entity.sys.SysResource;
import com.sun.project.common.vo.sys.SysResourceVo;

/**
 * <p>
 * 资源表 服务类
 * </p>
 *
 * @author sun
 * @since 2024-11-12
 */
public interface SysResourceService extends IService<SysResource> {

    Page<SysResourceVo> list(SysResource sysResource);
}
