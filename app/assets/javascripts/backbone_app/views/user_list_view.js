var UserListView = Backbone.View.extend({
	tagName: 'table',
	template: _.template($('#user-list-template').html()),
	render: function() {
		this.$el.html("");
		var renderedHTML = this.template({collection: this.collection});
		this.$el.html(renderedHTML);
		return this;
	}
});