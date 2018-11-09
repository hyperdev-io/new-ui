import request from 'request';
import {loginRequestType} from '../actions/auth';
import {authenticationFailed, tokenReceived, userLogoutRequestType} from '../actions/user';

const location = window.location;
const authEndpoint =
  process.env.REACT_APP_SERVER_API ||
  `${location.protocol}//${location.host}/api/account/login`;

export default ({ getState, dispatch }) => {
  if (localStorage && localStorage.getItem('token')) {
    setTimeout( () => dispatch(tokenReceived(localStorage.getItem('token'))), 0);
  }
  return next => action => {
    switch (action.type){
      case loginRequestType: {
        request.post({
          url: authEndpoint,
          json: {
            username: action.username,
            password: action.password,
          }
        }, (error, response) => {
          if (response.statusCode === 401) {
            dispatch(authenticationFailed());
          } else {
            if (localStorage) {
              localStorage.setItem('token', response.body.token);
            } else {
              console.debug('LocalStorage not available');
            }
            dispatch(tokenReceived(response.body.token));
          }
        });
        break;
      }
      case userLogoutRequestType: {
        localStorage && localStorage.removeItem('token');
        dispatch(tokenReceived(null));
        break;
      }
    }
    next(action);
  }
};