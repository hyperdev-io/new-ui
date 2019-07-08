const React = require("react");
const _ = require("lodash");
const {
  Box,
  Button,
  Heading,
  Header,
  Footer,
  Form,
  FormFields,
  FormField,
  TextInput,
  Select,
  Label,
  CheckBox,
  Anchor,
  Icons,
  Notification
} = require("grommet");
const createReactClass = require("create-react-class");

module.exports = createReactClass({
  displayName: "NewInstancePage",

  onPersistedStorageChange: function(evt) {
    this.props.onStateChanged({ stateful: evt });
  },

  getAppParams: function() {
    const params = this.props.selectedApp.dockerCompose
      ? this.props.selectedApp.dockerCompose.match(
          /(?:\{\{)([\d|\w|_|-]*?)(?=\}\})/g
        )
      : [];
    return _.uniq((params || []).map(p => p.replace("{{", "").trim()));
  },

  getAnyVolume: function() {
    return this.props.selectedApp.dockerCompose
      ? this.props.selectedApp.dockerCompose.match(
        /(volumes:[\s ]+-)/g
      )
      : false;
  },

  getAppNameFromProps: function() {
    if (this.props.selectedAppName && this.props.selectedAppVersion) {
      return `${this.props.selectedAppName} (${this.props.selectedAppVersion})`;
    }
  },
  onAppSelectChange: function(evt) {
    this.props.onAppSelected(evt.value.name, evt.value.version);
  },
  onBucketSelected: function(evt) {
    this.props.onStateChanged({ bucket: evt.option });
  },
  onAppSelectSearch: function(evt) {
    this.props.onStateChanged({ appsearch: evt.target.value });
  },
  onNameChange: function(evt, a, v) {
    this.props.onStateChanged({ name: evt.target.value });
  },

  onParamChanged: function(name) {
    return evt => {
      const obj = {};
      obj[`param_${name}`] = evt.target.value;
      this.props.onStateChanged(obj);
    };
  },
  appToOptionValue: app => ({
    value: `${app.name} (${app.version})`,
    id: app._id,
    name: app.name,
    version: app.version,
    label: (
      <Box direction="row" justify="between">
        <span>{app.name}</span>
        <span className="secondary">{app.version}</span>
      </Box>
    )
  }),
  getAppOptions: function() {
    _.filter(
      this.props.apps,
      app =>
        app.name.match(this.props.appsearch) ||
        app.version.match(this.props.appsearch)
    );
  },

  startInstance: function(evt) {
    this.props.onStartInstance();
  },
  renderAppParams: (params, onParamChanged) => (
    <fieldset>
      {params.length > 0 && (
        <Box direction="row" justify="between">
          <Heading tag="h3">App parameters</Heading>
        </Box>
      )}
      {params.map(param => (
        <FormField key={param} label={param} htmlFor={param} size="medium">
          <TextInput
            value={params ? [`param_${param}`] : ""}
            onDOMChange={onParamChanged(param)}
          />
        </FormField>
      ))}
    </fieldset>
  ),
  render: function() {
    return (
      <Box align="center" pad="medium">
        <Form compact={false} fill={false}>
          <Header size="large" pad="none" justify="between">
            <Heading tag="h2" margin="none" strong={true}>
              New Instance
            </Heading>
            <Anchor icon={<Icons.Base.Close />} onClick={this.props.onClose} />
          </Header>
          <FormFields>
            <fieldset>
              <FormField
                label="Application definition"
                htmlFor="app"
                size="medium"
              >
                <Select
                  placeHolder="Search"
                  inline={false}
                  multiple={false}
                  onSearch={this.onAppSelectSearch}
                  options={(this.getAppOptions() || this.props.apps).map(
                    this.appToOptionValue
                  )}
                  value={`${this.props.selectedAppName} (${
                    this.props.selectedAppVersion
                  })`}
                  onChange={this.onAppSelectChange}
                />
              </FormField>
              <FormField
                label="Instance name"
                htmlFor="name"
                size="medium"
                error=""
              >
                <TextInput
                  placeHolder="A unique name to identify this instance"
                  value={this.props.name}
                  onDOMChange={this.onNameChange}
                />
              </FormField>
            </fieldset>
            {this.props.selectedApp &&
            this.renderAppParams(this.getAppParams(), this.onParamChanged)}
            {this.props.selectedApp &&
            !this.getAnyVolume() &&

            (<Label>Warning! No volumes were specified - instance will be stateless</Label>) ||

            (<fieldset>
              <Box direction="row" justify="between">
                <CheckBox
                  toggle={true}
                  checked={this.props.stateful}
                  onChange={(evt) => this.onPersistedStorageChange(evt.target.checked)}
                  label={
                    <Heading style={{paddingTop: 10}} tag="h3">
                      Persisted Storage
                    </Heading>
                  }
                />
              </Box>
              {this.props.stateful && (<FormField label="Storage bucket" size="medium">
                <Select
                  onSearch={() => console.log("search")}
                  value={this.props.bucket || this.props.name}
                  onChange={this.onBucketSelected}
                  options={this.props.buckets}
                />
              </FormField>)}
            </fieldset>)}
          </FormFields>

          <Footer pad={{ vertical: "medium" }}>
            <Box direction="column" pad={{vertical: 'medium'}}>
              <Button
                type="button"
                primary={true}
                label="Start Instance"
                onClick={this.startInstance}
              />
            </Box>
          </Footer>
        </Form>
      </Box>
    );
  }
});
