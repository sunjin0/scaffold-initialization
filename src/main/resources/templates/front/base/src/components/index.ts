/**
 * 这个文件作为组件的目录
 * 目的是统一管理对外输出的组件，方便分类
 */
/**
 * 布局组件
 */
import Footer from './Footer';
import { Question, SelectLang } from './RightContent';
import { AvatarDropdown, AvatarName } from './RightContent/AvatarDropdown';
import {ProFormInstance} from "@ant-design/pro-components";
import React from "react";
export type Props = {
  id: string;
  request: (params: any) => Promise<any>;
  onSuccess: (values: any) => Promise<boolean>;
  open?: boolean;
  form: ProFormInstance
  setOpen?: (open: boolean) => void;
  children?: React.ReactNode;
  readonly?: boolean;
};
export { AvatarDropdown, AvatarName, Footer, Question, SelectLang };
