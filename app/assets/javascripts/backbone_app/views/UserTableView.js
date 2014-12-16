console.log("UserTableView");

var UserTableView = Backbone.View.extend({
  tagName: 'table', 
  template: _.template($('#user-table-template').html()),
  events: {
    "click tr.user-data" : "showPosts"
  },
  render: function(){
    var renderedHTML = this.template({ collection: this.collection });
    this.$el.html(renderedHTML);
    return this;
  }, 
  showPosts: function(e) { 
    var tr = e.target.parentElement.nextElementSibling;
    $(tr).slideToggle();
  }
})



