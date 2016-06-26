class Model
  getData: ->
    data =
      name: 'This is a string coming from the getData function.'
      items: [
        'item4'
        'item5'
        'item6'
      ]

module.exports = Model
