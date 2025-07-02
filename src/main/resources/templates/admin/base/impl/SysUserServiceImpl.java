package com.sun.project.impl.sys;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sun.project.api.mapper.sys.SysUserMapper;
import com.sun.project.api.service.sys.*;
import com.sun.project.common.dict.service.SysDictService;
import com.sun.project.common.entity.auth.SysToken;
import com.sun.project.common.entity.common.BaseEntity;
import com.sun.project.common.entity.message.MsgEmail;
import com.sun.project.common.entity.sys.*;
import com.sun.project.common.enums.common.State;
import com.sun.project.common.enums.message.EmailType;
import com.sun.project.common.enums.sys.ResourceType;
import com.sun.project.common.exception.ServerException;
import com.sun.project.common.i18n.I18nUtils;
import com.sun.project.common.local.CurrentUser;
import com.sun.project.common.utils.TokenUtils;
import com.sun.project.common.vo.sys.SysResourceVo;
import com.sun.project.common.vo.sys.SysUserVo;
import com.sun.project.email.service.EmailMessageService;
import org.apache.commons.lang3.RandomUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {


    @Resource
    private SysUserRoleService sysUserRoleService;


    @Resource
    private SysRoleResourceService sysRoleResourceService;

    @Resource
    private SysResourceService sysResourceService;

    @Resource
    private SysDictService sysDictService;

    @Resource
    private EmailMessageService emailService;

    @Resource
    private SysTokenService sysTokenService;

    @Resource
    private BCryptPasswordEncoder encoder;

    @Override
    public Boolean register(SysUserVo sysUser) throws ServerException {
        String email = sysUser.getEmail();
        String phone = sysUser.getPhone();
        Integer verificationCode = sysUser.getVerificationCode();
        // 检查邮箱和手机号是否已存在
        checkEmail(email);
        checkPhone(phone);
        // 验证码校验
        checkCode(email, verificationCode);
        sysUser.setPassword(encoder.encode(sysUser.getPassword()));
        return save(sysUser);
    }

    private void checkCode(String email, Integer verificationCode) {
        String captcha = sysDictService.getValue("Captcha");
        // 如果不开启验证码，直接通过
        if (!Boolean.parseBoolean(captcha)) {
            // 验证码校验
            LambdaQueryWrapper<MsgEmail> query = Wrappers.lambdaQuery(MsgEmail.class);
            query
                    .eq(MsgEmail::getEmail, email)
                    .eq(MsgEmail::getCode, verificationCode)
                    .eq(MsgEmail::getState, State.Success.getCode());
            MsgEmail one = emailService.getOne(query);
            if (one == null) {
                throw new ServerException(400, I18nUtils.getMessage("user.captcha.error"));
            } else {
                // 判断是否超过5分钟
                Date now = new Date();
                if (now.getTime() - one.getCreateAt() > 300000) {
                    one.setState(2);
                    emailService.update(one);
                    throw new ServerException(400, I18nUtils.getMessage("user.captcha.expired"));
                }
            }
            one.setState(2);
            emailService.update(one);

        }

    }

    @Override
    public Boolean resetPassword(SysUserVo sysUser) throws ServerException {
        String password = sysUser.getPassword();
        String oldPassword = sysUser.getOldPassword();
        SysUser user = getOne(Wrappers.lambdaQuery(SysUser.class)
                .eq(SysUser::getId, CurrentUser.getUser().get("userId"))
                .eq(SysUser::getState, State.Success.getCode()));
        if (encoder.matches(oldPassword, user.getPassword())) {
            user.setPassword(encoder.encode(password));
            return updateById(user);
        } else {
            throw new ServerException(400, I18nUtils.getMessage("user.password.error"));
        }
    }

    @Override
    public Boolean verify(SysUserVo sysUser) throws ServerException {
        String account = sysUser.getAccount();
        String password = sysUser.getPassword();
        // 判断account是否是邮箱
        boolean matches = account.matches("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$");
        LambdaQueryWrapper<SysUser> query = Wrappers.lambdaQuery(SysUser.class);
        query.eq(SysUser::getState, State.Success.getCode());
        // 邮箱或手机号
        if (matches) {
            query.eq(SysUser::getEmail, account);
            // 检查邮箱
            checkEmail(account);
        } else {
            query.eq(SysUser::getPhone, account);
            // 检查手机号
            checkPhone(account);
        }
        SysUser user = getOne(query);
        if (user != null && !encoder.matches(password, user.getPassword())) {
            throw new ServerException(400, I18nUtils.getMessage("user.password.error"));
        }
        return true;
    }

    private void checkPhone(String account) throws ServerException {
        SysUser phone = this.getOne(Wrappers.lambdaQuery(SysUser.class)
                .eq(SysUser::getPhone, account)
                .eq(SysUser::getState, State.Success.getCode()));
        if (phone == null) {
            throw new ServerException(400, I18nUtils.getMessage("user.phone.not.exist"));
        }
    }

    private void checkEmail(String account) throws ServerException {
        SysUser email = this.getOne(Wrappers.lambdaQuery(SysUser.class)
                .eq(SysUser::getEmail, account)
                .eq(SysUser::getState, State.Success.getCode()));
        if (email == null) {
            throw new ServerException(400, I18nUtils.getMessage("user.email.not.exist"));
        }
    }

    @Transactional(rollbackFor = ServerException.class)
    @Override
    public SysUserVo login(SysUserVo sysUser) throws ServerException {
        String email = sysUser.getEmail();
        Integer verificationCode = sysUser.getVerificationCode();
        // 邮箱是否存在
        checkEmail(email);
        checkCode(email, verificationCode);
        SysUser one = getOne(Wrappers.lambdaQuery(SysUser.class)
                .eq(SysUser::getEmail, email)
                .eq(SysUser::getState, State.Success.getCode()));
        one.setPassword(null);
        BeanUtils.copyProperties(one, sysUser);
        //生成token
        HashMap<String, String> payload = new HashMap<>();
        payload.put("userId", sysUser.getId());
        //角色
        payload.put("role", one.getType());
        SysToken sysToken = TokenUtils.createToken(payload);
        sysUser.setToken(sysToken.getToken());
        sysUser.setRefreshToken(sysToken.getRefreshToken());
        sysTokenService.saveOrUpdate(sysToken, Wrappers.lambdaUpdate(SysToken.class)
                .eq(SysToken::getUserId, sysUser.getId()));
        return sysUser;

    }

    @Override
    public List<Integer> getRoleIdsByUserId(String userId) {
        List<SysUserRole> list = sysUserRoleService.list(Wrappers.<SysUserRole>lambdaQuery()
                .select(SysUserRole::getRoleId)
                .eq(SysUserRole::getUserId, userId));
        if (!list.isEmpty()) {
            return list.stream().map(SysUserRole::getRoleId).collect(Collectors.toList());
        }
        return Collections.emptyList();
    }

    @Override
    public Boolean bindRole(String userId, List<Integer> roleIds) {
        return sysUserRoleService.saveUserRoleIds(userId, roleIds);
    }

    @Override
    public List<SysResourceVo> getRouters() {
        List<SysResourceVo> routes = new ArrayList<>();
        HashMap<String, String> user = CurrentUser.getUser();
        String userId = user.get("userId");
        if (userId != null) {
            // 1.获取用户角色
            List<SysUserRole> roles = sysUserRoleService.list(Wrappers.<SysUserRole>lambdaQuery()
                    .select(SysUserRole::getRoleId)
                    .eq(SysUserRole::getState, State.Success.getCode())
                    .eq(SysUserRole::getUserId, userId));
            if (roles.isEmpty()) {
                return routes;
            }
            // 2.获取角色对应的资源
            List<Integer> roleIds = roles.stream().map(SysUserRole::getRoleId).collect(Collectors.toList());
            List<SysRoleResource> resources = sysRoleResourceService.list(Wrappers.<SysRoleResource>lambdaQuery()
                    .select(SysRoleResource::getResourceId)
                    .eq(SysRoleResource::getState, State.Success.getCode())
                    .in(SysRoleResource::getRoleId, roleIds)
                    .orderByAsc(SysRoleResource::getSortNum));
            if (resources.isEmpty()) {
                return routes;
            }
            // 3.获取资源
            Set<Integer> resourceIds = resources.stream().map(SysRoleResource::getResourceId).collect(Collectors.toSet());
            List<SysResourceVo> list = sysResourceService.list(Wrappers.<SysResource>lambdaQuery()
                    .eq(SysResource::getState, State.Success.getCode())
                    .in(SysResource::getId, resourceIds)
                    .orderByAsc(SysResource::getSortNum)).stream().map(v -> {
                SysResourceVo resourceVo = new SysResourceVo();
                BeanUtils.copyProperties(v, resourceVo);
                String lng = I18nUtils.getMessage("lng");
                resourceVo.setTitle(v.getName());
                resourceVo.setName(lng.equals("en_US") ? resourceVo.getName() : resourceVo.getNameCn());
                return resourceVo;
            }).collect(Collectors.toList());
            if (list.isEmpty()) {
                return routes;
            }

            // 5.构建树形结构,使用队列
            Map<String, SysResourceVo> map = new HashMap<>();
            list.forEach(v -> map.put(v.getId(), v));
            Queue<SysResourceVo> queue = new LinkedList<>(list);
            while (!queue.isEmpty()) {
                SysResourceVo poll = queue.poll();
                SysResourceVo parent = map.get(poll.getParentId().toString());
                if (parent != null) {
                    if (parent.getChildren() == null) {
                        parent.setChildren(new ArrayList<>());
                    }
                    parent.getChildren().add(poll);
                }
                map.put(poll.getId(), poll);
            }

            // 6.设置权限标识
            Collection<SysResourceVo> sysResourceVos = map.values();
            routes = sysResourceVos.stream()
                    .filter(item -> item.getType().equals(ResourceType.ROUTE.getCode()))
                    .filter(item -> item.getParentId() == 0)
                    .sorted(Comparator.comparing(BaseEntity::getSortNum))
                    .collect(Collectors.toList());
            Stack<Collection<SysResourceVo>> stack = new Stack<>();
            stack.add(routes);
            while (!stack.isEmpty()) {
                Collection<SysResourceVo> item = stack.pop();
                item.forEach(v -> {
                    if (v.getChildren() != null) {
                        if (v.getChildren().get(0).getType().equals(ResourceType.PERMISSION.getCode())) {
                            v.setAccess(v.getChildren().stream().map(SysResourceVo::getTitle).collect(Collectors.joining(",")));
                            v.setChildren(null);
                        } else
                            stack.add(v.getChildren());
                    }
                });
            }
            return routes;
        }
        return routes;
    }

    @Override
    public SysUserVo detail() {
        SysUserVo userVo = new SysUserVo();
        HashMap<String, String> currentUser = CurrentUser.getUser();
        if (currentUser == null || currentUser.get("userId") == null) {
            return userVo;
        }
        SysUser user = this.getById(currentUser.get("userId"));
        user.setPassword(null);
        BeanUtils.copyProperties(user, userVo);
        List<SysResourceVo> routers = this.getRouters();
        HashMap<String, Object> map = new HashMap<>();
        if (!routers.isEmpty()) {
            for (SysResourceVo router : routers) {
                if (router.getChildren() != null) {
                    router.getChildren().forEach(child -> {
                        if (child.getAccess() != null) {
                            map.put(child.getPath(), child.getAccess().contains("Write"));
                        }
                    });
                }
            }
        }
        try {
            String token = currentUser.get("token");
            TokenUtils.isExpired(token);
            map.put("/sys", false);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        userVo.setPermissionMap(map);
        return userVo;
    }

    @Async
    @Override
    public void sendVerificationCode(String email) {
        SysUser sysUser = this.getOne(Wrappers.<SysUser>lambdaQuery()
                .eq(SysUser::getEmail, email)
                .eq(SysUser::getState, State.Success.getCode()));
        if (sysUser == null) {
            throw new ServerException(I18nUtils.getMessage("user.email.not.exist"));
        }
        try {
            MsgEmail msgEmail = new MsgEmail();
            msgEmail.setEmail(email);
            msgEmail.setCode(RandomUtils.nextInt(100000, 999999));
            msgEmail.setType(EmailType.VERIFICATION_CODE.getCode());
            SysDict subject = sysDictService.getByCode("email_template_login_subject", null);
            msgEmail.setSubject(subject.getName());
            SysDict body = sysDictService.getByCode("email_template_login_content", null);
            msgEmail.setBody(body.getName().replace("${code}", msgEmail.getCode().toString()));
            emailService.send(msgEmail);
        } catch (ServerException e) {
            throw new ServerException(400, e.getMessage());
        }
    }

    @Override
    public boolean logout() {
        return sysTokenService.update(Wrappers.<SysToken>lambdaUpdate()
                .eq(SysToken::getUserId, CurrentUser.getUser().get("userId"))
                .set(SysToken::getState, State.Delete.getCode()));
    }
}
