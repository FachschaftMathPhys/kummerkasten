import Ember from 'ember';
import DS from 'ember-data';
export default Ember.Controller.extend({
  session:Ember.inject.service('session'),
  paperToaster:Ember.inject.service(),
  actions:{
    login:function(){
      let {email,password}=this.getProperties('email','password');
      this.get('session').authenticate('authenticator:devise',email,password).catch((reason)=>{
        this.set('errorMessage',reason.error);
      }).then((data)=>
    {
      this.transitionToRoute("/inbox");
    });
    },
    logout:function(){
      this.get('session').invalidate();
    },
}
});
