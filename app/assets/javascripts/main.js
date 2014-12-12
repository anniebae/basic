var userCollection = new UserCollection(),
	router;

userCollection.fetch().done(function(){
	router = new Router({
		collection: userCollection,
		$el: $('.users')
	});
	Backbone.history.start();
});



// NOT SURE ABOUT BELOW
var userListView = new UserListView({
	collection: userCollection
})

userListView.fetch().done(function(){
	router = new Router({
		collection: userCollection
	})
})


$(document).ready(function(e){
	$('#dropdown').on('click', function() {
		$('.dropdownposts').slideToggle();
	});
})
