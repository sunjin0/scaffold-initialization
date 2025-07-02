package com.sun.project.impl.sys;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sun.project.api.mapper.sys.SysTokenMapper;
import com.sun.project.api.service.sys.SysTokenService;
import com.sun.project.common.entity.auth.SysToken;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 令牌表 服务实现类
 * </p>
 *
 * @author sun
 * @since 2024-11-27
 */
@Service
public class SysTokenServiceImpl extends ServiceImpl<SysTokenMapper, SysToken> implements SysTokenService {

}
