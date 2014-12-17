var Router = Backbone.Router.extend({
  initialize: function(options) {
    this.collection = options.collection;
    this.$el = options.$el;
  },

  routes: {
    "users"     : "index",
    "users/new" : "new",
    "users/:id" : "show"
  },
  

  setView: function(view){
    if (this.view) {
      this.view.remove();
      this.view = null;
    }
    this.view = view;
    this.$el.html(this.view.render().$el);
  },
  index: function() {
    var view = new UserTableView({
      collection: this.collection });
    this.setView(view);
  },
  show: function(id) {
    var user = this.collection.find(function(user){
      return user.get('id') === parseInt(id);
    })
    var view = new UserProfileView({ model: user });
    this.setView(view);
  },
  new: function() {
    var view = new NewUserView();
    this.setView(view);
  }
});