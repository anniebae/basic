var NewUserView = Backbone.View.extend({
	className: "user-form",
	template: _.template($("#new-user-view-template").html()),
	events: {
		"submit" : "createUser"
	},
	render: function(){
		this.$el.html(this.template());
		return this;
	},
	createUser: function(e){
		e.preventDefault();
		userCollection.create({
			name: this.$("input[name='name']").val(),
			password: this.$("input[name='password']").val(),
			instagram_account: this.$("input[name='instagram_account']").val(),
		});
		router.navigate('users', { trigger: true })
	}
});