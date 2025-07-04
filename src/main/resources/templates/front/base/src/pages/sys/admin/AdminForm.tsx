import DrawerForm from "@/components/DrawerForm";
import {request, useIntl} from "@umijs/max";
import {Form, message} from "antd";
import {ProFormSelect, ProFormText} from "@ant-design/pro-components";

const AdminForm = (props: {
  id: any;
  open?: boolean;
  setOpen?: (open: boolean) => void;
  onSuccess: () => void
}) => {
  const {id, open, setOpen, onSuccess} = props
  const intl = useIntl()
  const [form] = Form.useForm();
  return (
    <DrawerForm
      open={open}
      setOpen={setOpen}
      id={id}
      request={async (params) => await request('/api/chat/system/sys-admin/info', {params: {id: params}})}
      onSuccess={async (values) => {
        if(!values.avatar){
          values.avatar = 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png'
        }
        const {code, message: msg} = await request('/api/chat/system/sys-admin/save', {
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
        name={'roleIds'}
        label={intl.formatMessage({id: 'pages.sys.role.name'})}
        rules={[{required: true}]}
        request={async () => {
          const {data} = await request("/api/chat/system/sys-role/options", {
            method: 'GET',
          });
          return data
        }}
        fieldProps={{
          mode: 'multiple'
        }}
      />
      <ProFormText
        name={'username'}
        label={intl.formatMessage({id: 'pages.common.name'})}
        rules={[{required: true}]}
      />
      <ProFormSelect
        name={'sex'}
        label={intl.formatMessage({id: 'pages.common.gender'})}
        rules={[{required: true}]}
        request={async () => {
          const {data} = await request('/api/chat/system/sys-dict/options', {
            method: 'GET',
            params: {parentCode: 'Gender_Type'}
          });
          return data;
        }}
      />
      <ProFormSelect
        name={'type'}
        label={intl.formatMessage({id: 'pages.common.type'})}
        rules={[{required: true}]}
        request={async () => {
          const {data} = await request('/api/chat/system/sys-dict/options', {
            method: 'GET',
            params: {parentCode: 'System_Role'}
          });
          return data;
        }}
      />
      <ProFormText
        name={'email'}
        label={intl.formatMessage({id: 'pages.common.email'})}
        rules={[{required: true}]}
      />
      <ProFormText
        name={'phone'}
        label={intl.formatMessage({id: 'pages.common.phone'})}
        rules={[{required: true}]}
      />
    </DrawerForm>);
};
export default AdminForm;
