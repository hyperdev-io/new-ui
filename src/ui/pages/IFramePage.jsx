import React from 'react';
import { Button, Header, Icons, Menu, Sidebar, Split, Anchor } from 'grommet';

export default ({ route: { iFramePath }}) => (
  <Split flex='left' priority='left' id='iframe-split'>
    <iframe border="0" style={{width: '100%', height: '100%', border: 0}} src={iFramePath} scrolling="no" />
    <Sidebar size='medium' colorIndex='light-2' direction='column'>
      <Header pad='medium' size='large' direction='column'>
      </Header>
      <Menu pad='medium' fill={true} >
        <Button className='active' path='/portal' plain={true} label='Users' icon={<Icons.Base.UserSettings />}></Button>
        <Button path='/portal/subscription' plain={true} label='Subscription' icon={<Icons.Base.Services />}></Button>
        <Button path='/portal/invoices' plain={true} label='Invoices' icon={<Icons.Base.Money />}></Button>
        <Button path='/token' plain={true} label='Security' icon={<Icons.Base.ShieldSecurity />}></Button>
      </Menu>
    </Sidebar>
  </Split>
);