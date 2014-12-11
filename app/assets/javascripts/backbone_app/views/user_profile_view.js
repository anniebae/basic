var UserProfileView = Backbone.View.extend({
	className: 'profile',
	template: _.template($('#user-profile-template').html()),
	initialize: function(){
		this.listenTo(this.model, 'change', this.render);
	},
	render: function(){
		this.$el.html(this.template(this.model.toJSON()));
		return this;
	},
})