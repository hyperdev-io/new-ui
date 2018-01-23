const React = require("react");
const Notifications = require("react-notification-system-redux");
const { connect } = require("react-redux");

const style = {
  NotificationItem: {
    DefaultStyle: {
      margin: "10px 5px 2px 1px"
    }
  }
};

const notificationsComponent = ({ notifications }) => (
  <Notifications notifications={notifications} style={style} />
);

const mapStateToProps = state => ({ notifications: state.notifications });

module.exports = connect(mapStateToProps)(notificationsComponent);
