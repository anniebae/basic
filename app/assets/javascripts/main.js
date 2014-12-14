var userCollection, 
    router;

$(function(){


  userCollection = new UserCollection();

  userCollection.fetch().done(function(){
    router = new Router({
        collection: userCollection, 
        $el: $('.table-container')
      });
      Backbone.history.start();
    });
});


