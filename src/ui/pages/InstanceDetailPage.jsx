const React = require("react");
const _ = require("lodash");
const moment = require("moment");
const DetailPage = require("../DetailPage");
const Helpers = require("../Helpers");

const {
  Anchor,
  Box,
  Header,
  Split,
  Sidebar,
  Notification,
  Section,
  List,
  ListItem,
  Heading,
  Button,
  Icons,
  Paragraph,
} = require("grommet");

const InstanceControls = require("../menus/InstanceControls");
const { Terminal } = require("../Terminal");

const createReactClass = require("create-react-class");

const avatarStyle = {
  width: 20,
  height: 20,
  borderRadius: 150,
  WebkitBorderRadius: 150,
  MozkitBorderRadius: 150,
  marginRight: 10
};

const li = (name, val) => (
  <ListItem justify="between">
    <span>{name}</span>
    <span className="secondary">{val}</span>
  </ListItem>
);

module.exports = createReactClass({
  displayName: "InstanceDetailPage",

  copyToClipboard: data => () => {
    const element = document.createElement("textarea");
    element.value = data;
    document.body.appendChild(element);
    element.focus();
    element.setSelectionRange(0, element.value.length);
    document.execCommand("copy");
    document.body.removeChild(element);
  },
  render: function() {
    if (this.props.notFound) {
      return (
        <Box
          align="center"
          textAlign="center"
          alignContent="center"
          direction="column"
          full={true}
          justify="center"
        >
          <Box width={150}>
            <h1>Instance not found...</h1>
            <Paragraph size="large">
              Probably this instance was just terminated. Anyhow, it doesn&#39;t
              exist anymore.
            </Paragraph>
            <Box align="center" colorIndex="light-3" pad="medium">
              <Button
                label="Take me to the instances"
                primary={true}
                path="/instances"
              />
            </Box>
          </Box>
        </Box>
      );
    } else {
      return this.renderWithData();
    }
  },
  renderWithData: function() {
    const avatarAndName = () => (
      <span>
        <img style={avatarStyle} src={this.props.startedBy.gravatar} alt="" />
        {this.props.startedBy.fullname}
      </span>
    );

    const iconLink = (content, onClickHandler, icon = Icons.Base.Link) => (
      <Anchor
        onClick={onClickHandler}
        icon={<icon style={{ width: 20 }} />}
        label={
          <span style={{ fontSize: 16, fontWeight: "normal" }}>{content}</span>
        }
      />
    );

    const appWithLink = () =>
      iconLink(
        `${this.props.instance.app.name}:${this.props.instance.app.version}`,
        this.props.onOpenAppPage
      );

    const renderStatus = s => {
      let status = s.health && s.health.status ? s.health.status : "";
      status =
        status === "unknown"
          ? "waiting for container to become healthy"
          : status;
      return (
        <span>
          {s.state} {status ? `(${status})` : ""}
        </span>
      );
    };

    const renderNetwork = net => {
      if (net) {
        const ip = net.ip ? `, ip: ${net.ip}` : "";
        var status = net.health && net.health.status ? net.health.status : "";
        status =
          status === "unknown"
            ? "waiting for container to become healthy"
            : status;
        return (
          <span>
            {net.state} ({status}
            {ip})
          </span>
        );
      }
    };

    const renderSsh = ssh =>
      iconLink(
        `ssh ${ssh.fqdn}`,
        this.copyToClipboard`ssh ${ssh.fqdn}`,
        Icons.Base.Copy
      );

    const instanceHelper = Helpers.withInstance(this.props.instance);

    var titleComponent = this.props.title;
    if (this.props.instanceLink) {
      titleComponent = (
        <Anchor
          reverse={true}
          href={this.props.instanceLink}
          target="_blank"
          icon={<Icons.Base.Link style={{ width: 60, marginBottom: 20 }} />}
          label={
            <Heading tag="h1" style={{ display: "inline-block" }} strong={true}>
              {this.props.title}
            </Heading>
          }
        />
      );
    }

    return (
      <Split flex="left" priority="left">
        <DetailPage title={titleComponent}>
          <Notification
            pad="medium"
            status={instanceHelper.getStateValue()}
            message={instanceHelper.getStatusText()}
          />
          <Section pad="medium">
            <List>
              {li("Application", appWithLink())}
              {this.props.instance.storageBucket &&
                li(
                  "Storage bucket",
                  iconLink(
                    this.props.instance.storageBucket,
                    this.props.onOpenBucketPage
                  )
                )}
              {li("Started by", avatarAndName())}
            </List>
          </Section>
          <div className="terminal-wrapper">
            <Terminal outputStyle={{ minHeight: 100, maxHeight: 250 }}>
              <kbd>docker-compose up</kbd>
              <pre>
                {this.props.instance.logs &&
                  this.props.instance.logs.startup.join("")}
              </pre>
              {this.props.instance.state === "running" && (
                <pre>done. instance running</pre>
              )}
              {this.props.instance.logs &&
                this.props.instance.logs && <kbd>docker-compose down</kbd>}
              {this.props.instance.logs &&
                this.props.instance.logs && (
                  <pre>{this.props.instance.logs.teardown.join("")}</pre>
                )}
            </Terminal>
          </div>
          {(!this.props.instance || !this.props.instance.services) && (
            <Box alignContent="center" pad="large" align="center">
              <h3>
                Service information will be displayed here as soon as the
                instance starts...
              </h3>
            </Box>
          )}
          {_.map(this.props.instance.services, service => (
            <Section key={service.name} pad="medium">
              <Header style={{ minHeight: 0, margin: "0px 20px 0px 0px" }}>
                <Anchor
                  reverse={true}
                  href={this.props.serviceLinks[service.name]}
                  target="_blank"
                  icon={<Icons.Base.Link style={{ width: 20 }} />}
                  label={
                    <span style={{ fontSize: 26, fontWeight: "normal" }}>
                      {service.name}
                    </span>
                  }
                />

                <Box flex={true} justify="end" direction="row">
                  <Anchor
                    reverse={true}
                    target="_blank"
                    path={`/instances/${this.props.instance.name}/${
                      service.name
                    }/logs`}
                    label={
                      <span style={{ fontSize: 20, fontWeight: "normal" }}>
                        Logs
                      </span>
                    }
                  />
                </Box>
              </Header>
              <List>
                {service.container &&
                  li("Created", moment(service.container.created).fromNow())}
                {li("State", renderStatus(service))}
                {li("FQDN", service.fqdn)}
                {service.container &&
                  li("Container name", service.container.name)}
                {li("Ports", service.ports)}
                {service.aux && li("Network", renderNetwork(service.aux.net))}
                {service.aux && li("SSH", renderSsh(service.aux.ssh))}
              </List>
            </Section>
          ))}
        </DetailPage>
        <Sidebar size="medium" colorIndex="light-2" direction="column">
          <Header pad="medium" size="large" />
          <InstanceControls
            instanceName={this.props.instance.name}
            onStopInstance={this.props.onStopInstance}
          />
        </Sidebar>
      </Split>
    );
  }
});
