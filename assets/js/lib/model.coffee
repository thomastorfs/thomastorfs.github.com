jade = require 'jade'
Resizers = require './image/resizers'

# Define the default Jade options
jadeOptions = {
  resize: new Resizers
}

# Create our Model class
class Model
  getAllData: ->
    this.getProjects()
  getProjects: ->
    [
      {
        title: 'Aristide',
        type: 'webdevelopment',
        linkTitle: 'See how the Aristide project was made.',
        content: jade.renderFile('data/work/aristide/index.jade', jadeOptions)
      },
      {
        title: 'AE',
        type: 'webdevelopment',
        linkTitle: 'See how the AE project was made.',
        content: jade.renderFile('data/work/ae/index.jade', jadeOptions)
      }
    ]

module.exports = Model
