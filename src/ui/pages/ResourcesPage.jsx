const React = require("react");
const filesize = require('filesize')

const {
  Article,
  Box,
  Header,
  Title,
  Split,
  Sidebar,
  Paragraph,
  Icons,
  List,
  ListItem,
  Tiles,
  Tile,
  Label,
  Meter,
  Value
} = require("grommet");
const { Status } = Icons;
const Loading = require("../Loading");
const createReactClass = require("create-react-class");


const renderCpu = cpu => {
    return <Box align="center" direction="column" pad="small">
        <Label size="small">CPU</Label>
        <Meter threshold={90} vertical={false} type="arc" size="xsmall" max={100} value={cpu.used} />
        <Value value={cpu.used} units="%" size="xsmall" />
      </Box>;
  }
const renderMemory = memory => {
  const memTotal = filesize(memory.total, { output: "object" });
  const memUsed = filesize(memory.used, { output: "object" });
  return (
    <Box align="center" direction="column" pad="small">
      <Label size="small">Memory</Label>
      <Meter
        threshold={memTotal.value}
        vertical={false}
        type="arc"
        size="xsmall"
        max={memTotal.value}
        value={memUsed.value}
      />
      <Value value={memUsed.value} units={memUsed.suffix} size="xsmall" />
      <Label size="small">
        {memTotal.value} {memTotal.suffix}
      </Label>
    </Box>
  );
};
const renderDisk = disk => {
  const diskTotal = filesize(disk.total, { output: "object" });
  const diskUsed = filesize(disk.used, { output: "object" });
  return <Box align="center" direction="column" pad="small">
      <Label size="small">Disk</Label>
      <Meter type="arc" value={diskUsed.value} max={diskTotal.value} size="xsmall" />
      <Value value={diskUsed.value} units={diskUsed.suffix} size="xsmall" />
      <Label size="small">
        {diskTotal.value} {diskTotal.suffix}
      </Label>
    </Box>;
}

module.exports = createReactClass({
  displayName: "ResourcesPage",

  render: function() {
    return (
      <Loading isLoading={this.props.isLoading} render={this.renderWithData} />
    );
  },
  renderSideBar: () => {
    return <Sidebar size="medium" colorIndex="light-2" direction="column">
      <Box align="center" justify="center" direction="column">
        <Header pad="medium" size="large" direction="column">
          <Title>
            <Icons.Base.Info />
          </Title>
          <Paragraph align="center">
            This page lists the availability of all resources and their
            status.
          </Paragraph>
        </Header>
      </Box>
    </Sidebar>
  },
  renderGroup: (groupName, items) => {
    return <span key={groupName}>
      <Header size="small" justify="start" separator="top" pad={{ horizontal: "small" }}>
        <Label size="small">{groupName}</Label>
      </Header>
      <Tiles selectable={true} pad={{ horizontal: "small" }} fill={false} flush={false} responsive={false}>
        {items.map(item => {
          return <Tile key={item.name} align="center" pad="small" direction="column" size={{ width: { min: "small" } }}>
              <Label>{item.name}</Label>
              <Box responsive={false} align="start" direction="row">
                {item.cpu && renderCpu(item.cpu)}
                {item.memory && renderMemory(item.memory)}
                {item.disk && renderDisk(item.disk)}
              </Box>
            </Tile>;
        })}
      </Tiles>
    </span>;
  },
  renderWithData: function() {
    const resources = this.props.resources;
    console.log("resources", resources);
    const services = []
    return <Split flex="left" priority="left">
        <Article>
          <Header fixed={true} pad="medium" justify="between">
            <Box justify="start" direction="row">
              <Title responsive={true} truncate={true}>
                Resources Overview
              </Title>
            </Box>
          </Header>
          {this.renderGroup("Compute Nodes", resources.compute)}
          {this.renderGroup("Storage Nodes", resources.storage)}
        </Article>
        {this.renderSideBar()}
      </Split>;
  }
});
