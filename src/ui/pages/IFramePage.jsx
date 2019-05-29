import React from 'react';

export default ({ route: { iFramePath }}) => (
  <iframe border="0" style={{width: '100%', height: '99vh', border: 0}} src={iFramePath} scrolling="no" />
);