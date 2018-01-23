const React = require('react');
const filesize = require('filesize');

const AnnotatedMeter = require('grommet-addons/components/AnnotatedMeter');

module.exports = React.createClass({
  displayName: 'DataStoreUsageMeter',

  render() {
    const exponent = filesize((this.props.used + this.props.free), { output: 'exponent' });

    const used = filesize(this.props.used, { output: "object", exponent });
    const free = filesize(this.props.free, { output: "object", exponent });
    const total = Math.round(used.value + free.value);

    const dataPoint = (label, value, colorIndex) => ({ label, value, colorIndex });

    const series = [
      dataPoint('Used', (Math.round(used.value)), 'neutral-3')
      ,
      dataPoint('Free', (Math.round(free.value)), 'unset')
    ];
    return (
      <AnnotatedMeter legend={true}
        type='circle'
        size='small'
        legend={true}
        units={used.suffix}
        max={total}
        series={series} />
    )
  }
});
