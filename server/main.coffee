import { Meteor } from 'meteor/meteor';

Meteor.startup ->
  unless Meteor.settings.public.ddpServer
    console.warn "ddpServer property not set!"
    console.warn "Make sure your settings file looks something like",
      public: ddpServer: 'http//my-ddp-server.com'

  console.log 'App started'
