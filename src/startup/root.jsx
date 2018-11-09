import Routes from "./routes";

const React = require("react");
const { Provider } = require("react-redux");

export default (store) => (
  <Provider store={store}>
    <Routes store={store} />
  </Provider>
)

