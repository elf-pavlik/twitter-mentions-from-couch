$ ->
  class UI extends Backbone.View

    el: $ 'body'

    events:
      'keypress': 'input'

    initialize: ->
      @collection.bind 'reset', =>
        @render()

    input: (event) ->
      return unless event.keyCode == 13
      @collection.fetch $('input').attr('value')

    render: ->
      templateMarkup = $('#tweet').html()
      $('#results').html('')
      for tweet in @collection.models
        templateCompiled = _.template templateMarkup, tweet.toJSON()
        $('#results').append templateCompiled

  class Tweet extends Backbone.Model

  class TweetList extends Backbone.Collection

    model: Tweet

    initialize: ->
      @screenName

    setScreenName: (screenName) ->
      @screenName = screenName

    fetch: (screenName) ->
      $.getJSON '/mentions/' + screenName.toLowerCase(), (data) =>
        @reset()
        @reset(_.map data, (object) -> object.value)

  tweets = new TweetList
  ui = new UI collection: tweets
