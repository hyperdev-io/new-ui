{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
{ Link }            = require 'react-router'


module.exports = App = React.createClass
  displayName: 'App'
  render: ->
    <div>
      <h1>Title</h1>
      <ul>
        <li><Link to='/page1'>Page1</Link></li>
        <li><Link to='/page2'>Page2</Link></li>
      </ul>

      <div style={padding:25, backgroundColor:'lightgrey'}>
        {@props.children}
      </div>
    </div>
