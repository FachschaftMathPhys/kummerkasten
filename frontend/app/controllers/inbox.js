import Ember from 'ember';

export default Ember.Controller.extend({
  session:Ember.inject.service('session'),
  currentUser: Ember.inject.service('current-user'),
  paperToaster:Ember.inject.service(),
   router: Ember.inject.service(),
   currentRouteName: Ember.computed.reads('router.currentRouteName'),
  actions:{
    login:function(){
      let {email,password}=this.getProperties('email','password');
      this.get('session').authenticate('authenticator:devise',email,password).catch((reason)=>{
        this.set('errorMessage',reason.error);
      });
    },
    logout:function(){
      this.get('session').invalidate();
    },
}
});
