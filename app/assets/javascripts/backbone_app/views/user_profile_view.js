var UserProfileView = Backbone.View.extend({
	className: 'profile',
	template: function() { return _.template($('#user-profile-template').html()) },
	initialize: function(){
		this.listenTo(this.model, 'change', this.render);
		this.listenTo(this.model, 'add', this.render);
	},
	render: function(){
		this.$el.html(this.template()(this.model.toJSON()));
		return this;
	},
});