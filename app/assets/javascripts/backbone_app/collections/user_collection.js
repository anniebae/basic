console.log("UserCollection yay");

var UserCollection = Backbone.Collection.extend({
	model: User,
	url: '/users'
})