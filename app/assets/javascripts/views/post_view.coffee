window.PostView = Backbone.View.extend
  tagName:    "div"
  className:  "post"
  template:   JST["posts/show"]
    
  initialize: (options) ->
    _.bindAll @
    @model.on("change", => @render())
  
  render: ->
    @$el.html @template(@model.toJSON())
    @
    
    
window.PostsView = Backbone.View.extend
  tagName: "div"
  class: "posts"
  template:   JST["posts/index"]

  initialize: (options) ->
    _.bindAll @
    @views = []
    @initViews()
    @collection.on("add remove reset", @render)
    
  initViews: ->
    @collection.each (post) =>
      view = new PostView(model: post, el: "#post_#{post.id}")
      @views.push view
    
  render: ->
    @$el.html @template(data: @collection.toJSON())
    @initViews()
    @