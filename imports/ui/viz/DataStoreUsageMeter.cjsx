React               = require 'react'
filesize            = require 'filesize'

AnnotatedMeter = require 'grommet-addons/components/AnnotatedMeter'

module.exports = React.createClass
  displayName: 'DataStoreUsageMeter'

  render: ->
    exponent = filesize (@props.used + @props.free), output: 'exponent'

    used = filesize @props.used, {output: "object", exponent: exponent}
    free = filesize @props.free, {output: "object", exponent: exponent}
    total = Math.round used.value + free.value

    dataPoint = (label, value, colorIndex) -> label: label, value: value, colorIndex: colorIndex

    series = [
      dataPoint 'Used', (Math.round used.value), 'neutral-3'
    ,
      dataPoint 'Free', (Math.round free.value), 'unset'
    ]

    <AnnotatedMeter legend={true}
      type='circle'
      size='small'
      legend=true
      units={used.suffix}
      max={total}
      series={series} />
