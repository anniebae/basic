
var userCollection, 
    router,
    $submitButton;

$(function(){

  // $submitButton = $("#survey-submit");
  // $submitButton.on('click', function(e){
  //   e.preventDefault();
  //   $.ajax({
  //     url: "/users/",
  //     method: "patch",
  //     data: "stuff",
  //     success: function(){
  //       console.log('yay');
      
  //     router.navigate('users');
  //     }
  //   })
  // })

  userCollection = new UserCollection();

  userCollection.fetch().done(function(){
    router = new Router({
        collection: userCollection, 
        $el: $('.table-container')
      });
      Backbone.history.start();
    });
});


