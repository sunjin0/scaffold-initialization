import React, {useState} from "react";
import DrawerForm from "@/components/DrawerForm";
import {request, useIntl} from "@umijs/max";
import {Form, message} from "antd";
import {ProFormSelect, ProFormText, ProFormTextArea} from "@ant-design/pro-components";
import {ProFormDependency} from "@ant-design/pro-form";

const ResourceForm = (props: {
  id: any;
  open?: boolean;
  setOpen?: (open: boolean) => void;
  onSuccess: () => void
}) => {
  const {id, open, setOpen, onSuccess} = props
  const [form] = Form.useForm();
  const intl = useIntl()
  const [readOnly, setReadOnly] = useState(false)
  return (
    <DrawerForm
      readonly={readOnly}
      id={id}
      request={async (params) => {
        const res = await request('/api/chat/system/sys-resource/info', {
          method: 'GET',
          params: {id: params}
        });
        if (res.data.type !== 'Resource_Type_Route') {
          setReadOnly(true)
        }
        return res;
      }}
      open={open}
      setOpen={(open) => {
        if (open!) {
          setReadOnly(false)
        }
        if (setOpen) {
          setOpen(open)
        }
      }}
      onSuccess={async (values: any) => {
        const {code, message: msg} = await request('/api/chat/system/sys-resource/save', {
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
      <ProFormSelect
        name="parentId"
        label={intl.formatMessage({id: 'pages.sys.resource.menu.parent'})}
        showSearch={true}
        request={async () => {
          const {data} = await request('/api/chat/system/sys-resource/select', {});
          return data;
        }}
      />
      <ProFormText
        name="name"
        label={intl.formatMessage({id: 'pages.common.name.en'})}
        rules={[{required: true}]}
      />
      <ProFormText
        name="nameCn"
        label={intl.formatMessage({id: 'pages.common.name.zh'})}
        rules={[{required: true}]}
      />
      <ProFormSelect
        name="type"
        label={intl.formatMessage({id: 'pages.common.type'})}
        rules={[{required: true}]}
        request={async () => {
          const {data} = await request("/api/chat/system/sys-dict/options", {
            method: 'GET',
            params: {parentCode: 'Resource_Type'}
          });
          return data;
        }}

      />
      <ProFormDependency name={['type']}>
        {({type}) => {
          const b = type === 'Resource_Type_Route';
          return <ProFormText
            name="path"
            label={intl.formatMessage({id: 'pages.sys.resource.menu.path'})}
            required={b}
            rules={[{required: b}]}
          />
        }}
      </ProFormDependency>
      <ProFormText
        name="icon"
        label={intl.formatMessage({id: 'pages.sys.resource.menu.icon'})}
      />
      <ProFormText
        name="sortNum"
        label={intl.formatMessage({id: 'pages.common.sort.number'})}
        rules={[{required: true}]}
      />
      <ProFormTextArea
        name="description"
        label={intl.formatMessage({id: 'pages.common.description'})}
      />
    </DrawerForm>
  )

}
export default ResourceForm
