console.log("UserTableView");

var UserTableView = Backbone.View.extend({
  tagName: 'table', 
  template: _.template($('#user-table-template').html()),
  render: function(){
    var renderedHTML = this.template({ collection: this.collection });
    this.$el.html(renderedHTML);
    return this;
  }
})
