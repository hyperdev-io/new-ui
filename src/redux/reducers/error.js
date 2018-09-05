import { toast } from "react-toastify";
const { merge } = require('./utils');

export default function(state = {}, action) {
  switch (action.type) {
    case 'ERROR':
      if (action.error.info) toast.warn(action.error.info);
      if (action.error.path) {
        const obj = {};
        obj[action.error.path[0]] = {
          message: action.error.message,
          info: action.error.info,
          props: action.error.props
        };
        return merge(state, obj);
      }
  };
  return state;
};
