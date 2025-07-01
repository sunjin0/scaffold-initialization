import React, {useRef, useState} from "react";

import {ActionType, PageContainer, ProTable} from "@ant-design/pro-components";
import {request, useIntl, history} from "@umijs/max";
import {Button, Image, message, Popconfirm} from "antd";
import AdminForm from "@/pages/Sys/admin/AdminForm";
import {useAccess} from "@@/exports";

const Admin: React.FC = () => {
  const intl = useIntl()
  const [open, setOpen] = useState(false);
  const [id, setId] = useState(undefined);
  const ref = useRef<ActionType>()
  const permissionMap = useAccess();
  const path = history.location.pathname
  const write = permissionMap[path]
  const columns: any[] = [
    {
      title: intl.formatMessage({id: 'pages.sys.role.name'}),
      dataIndex: 'roleIds',
      valueType: 'select',
      request: async () => {
        const {data} = await request('/api/chat/system/sys-role/options', {});
        return data;
      },
      fieldProps: {
        mode: 'multiple'
      },
      hideInSearch: true,
      key: 'roleIds',
    },
    {
      title: intl.formatMessage({id: 'pages.common.name'}),
      dataIndex: 'username',
      key: 'username',
    },
    {
      title: intl.formatMessage({id: 'pages.common.gender'}),
      dataIndex: 'sex',
      valueType: 'select',
      request: async () => {
        const {data} = await request('/api/chat/system/sys-dict/options', {
          method: 'GET',
          params: {parentCode: 'Gender_Type'}
        });
        return data;
      },
      key: 'sex',
    },
    {
      title: intl.formatMessage({id: 'pages.common.avatar'}),
      dataIndex: 'avatar',
      render: (text: string) => <Image src={text} width={40} height={40} alt={""}/>,
      key: 'avatar',
      hideInSearch: true,

    },
    {
      title: intl.formatMessage({id: 'pages.common.type'}),
      dataIndex: 'type',
      valueType: 'select',
      request: async () => {
        const {data} = await request('/api/chat/system/sys-dict/options', {
          method: 'GET',
          params: {parentCode: 'System_Role'}
        });
        return data;
      },
      key: 'type',
    },
    {
      title: intl.formatMessage({id: 'pages.common.email'}),
      dataIndex: 'email',
      key: 'email',
    },
    {
      title: intl.formatMessage({id: 'pages.common.phone'}),
      dataIndex: 'phone',
      key: 'phone',
    },
    {
      title: intl.formatMessage({id: 'pages.common.option'}),
      dataIndex: 'option',
      key: 'option',
      valueType: 'option',
      render: (text: any, record: any, _: any, action: any) => write && [
        <Button
          type={'link'}
          key="editable"
          onClick={() => {
            setId(record.id)
            setOpen(true)
          }}
        >
          {intl.formatMessage({id: 'pages.common.edit'})}
        </Button>,
        <Popconfirm
          key={'delete'}
          title={intl.formatMessage({id: 'pages.confirm.delete'})}
          onConfirm={async () => {
            const {code, message: msg} = await request('/api/chat/system/sys-admin/delete', {
              method: 'GET',
              params: {id: record.id}
            });
            if (code === 200) {
              message.success(msg)
            } else {
              message.error(msg)
            }
            action?.reload()
          }}
        >
          <Button type={'link'}
          >
            {intl.formatMessage({id: 'pages.common.delete'})}
          </Button>
        </Popconfirm>
      ],
    }
  ]
  return (
    <PageContainer>
      <ProTable
        actionRef={ref}
        rowKey={'user'}
        columns={columns}
        request={async (params) => request('/api/chat/system/sys-admin/list', {method: 'POST', data: params})}
      />
      <AdminForm
        id={id}
        open={open}
        setOpen={setOpen}
        onSuccess={() => {
          setId(undefined)
          ref.current?.reload()
        }}
      />
    </PageContainer>
  );
};

export default Admin;
