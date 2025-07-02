import React, { useState} from "react";
import DrawerForm from "@/components/DrawerForm";
import {request, useIntl} from "@umijs/max";
import {Form, message} from "antd";
import { ProFormText, ProFormTextArea} from "@ant-design/pro-components";

const RoleForm = (props: {
  id: any;
  open?: boolean;
  setOpen?: (open: boolean) => void;
  onSuccess: () => void
}) => {
  const {id, open, setOpen, onSuccess} = props
  const [form] = Form.useForm();
  const intl = useIntl()
  return (
    <DrawerForm
      request={async (params) => await request('/api/chat/system/sys-role/info', {
        method: 'GET',
        params: {id: params}
      })}
      id={id}
      open={open}
      setOpen={setOpen}
      onSuccess={async (values: any) => {
        const {code, message: msg} = await request('/api/chat/system/sys-role/save', {
          method: 'POST',
          data: values
        });
        onSuccess();
        if (code === 200) {
          message.success(msg)
          return true;
        } else {
          message.error(msg)
          return false
        }
      }}
      form={form}
    >
      <ProFormText
        name={'id'}
        hidden={true}
      />
      <ProFormText
        name="name"
        label={intl.formatMessage({id: 'pages.common.name'})}
        rules={[{required: true}]}
      />
      <ProFormText
        name="sortNum"
        label={intl.formatMessage({id: 'pages.common.sort.number'})}
        rules={[{required: true}]}
      />
      <ProFormTextArea
        name="description"
        label={intl.formatMessage({id: 'pages.common.description'})}
        fieldProps={{
          maxLength: 1024,
          showCount: true
        }}
      />
    </DrawerForm>
  )

}
export default RoleForm
